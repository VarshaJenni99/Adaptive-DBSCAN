IMPORT ML_Core;
IMPORT ML_Core.Analysis;
IMPORT $.^ AS DBSCAN;
IMPORT $.datasets.adap AS compound_data;
IMPORT $.datasets;
// Test to check the Num_clusters function

Records := compound_data.ds;
layout := compound_data.layout;



unsigned clusters( STREAMED DATASET(layout) ds, unsigned dim) := EMBED(C++)

    #include<iostream>
    #include<bits/stdc++.h>

    using namespace std;
		
		bool pdf(vector<vector<double> > &dataset,vector<double> landmark, double s2, int min_pts){

  	uint32_t d = 0;
		vector<int> kernels;
  	for(uint64_t  i = 0; i < dataset.size(); i++){
  		double a = 0.0;
  		for(uint64_t curr_var = 0; curr_var < dataset[0].size(); curr_var++){	
  			 
				 a += pow(-(dataset[i][curr_var] - landmark[curr_var]),2);
  		}
			a = exp(a/(2*s2)) *(1/sqrt(s2 * 2 *3.14));
			
			if(a >= 0.9)
			kernels.push_back(1);
			else
			kernels.push_back(0);

}  
		
		if(accumulate(kernels.begin(), kernels.end(), 0) >= min_pts)
		{
		
		vector<vector<double> >::iterator it; 
  
    it = dataset.begin();
  	
		for(uint32_t i = 0; i < kernels.size(); i++)
		{
				 if(kernels[i] == 1)
				 dataset.erase(it);
				 
				 it++;
		}
		return true;
		}
		else return false;
}
		#body
		vector<vector<double> > dataset;
     for(;;)
		{
			const byte *next = (const byte *)ds->nextRow();
			if(!next)
      break;
			const byte *p = next;
			vector<double> temp;
			
			for(uint32_t i=0; i<dim; ++i){
       double f = *((double*)p); p += sizeof(double);
			 
			 temp.push_back(f);
       }
			 
			 
			 dataset.push_back(temp);
			 	rtlReleaseRow(next);	
			
				}
				
				uint32_t c  = 0;
	
	vector<double> sum_x_map, sum_x2_map;
	for(uint64_t curr_var = 0;curr_var < dataset[0].size(); curr_var++)
		{
					sum_x_map.push_back(0.0);
					sum_x2_map.push_back(0.0);
					
					for(uint64_t i = 0; i < dataset.size(); i++){
							
							sum_x_map[curr_var] += dataset[i][curr_var];
							sum_x2_map[curr_var] += dataset[i][curr_var] * dataset[i][curr_var];			
			}		
		}
		
		//int d = dataset[0].size(); 
		double s2;
		for(uint64_t curr_var = 0; curr_var < dataset[0].size(); curr_var++)
	{
		double x  = sum_x_map[curr_var]/dataset.size();
  	double x2 = sum_x2_map[curr_var];
  	 s2 += x2/dataset.size() - (x*x);
		}
		
		s2 = s2/dataset[0].size();
		for(uint32_t i = 0; i < dataset.size(); i++)
		{
			if((pdf(dataset, dataset[i],s2,39)))
				c++;
		}
		return c;
endembed;

output(clusters(Records, 2));