﻿/*##############################################################################
## HPCC SYSTEMS software Copyright (C) 2019 HPCC Systems.  All rights reserved.
############################################################################## */
IMPORT $.^.DBSCAN_Types AS Files;
IMPORT Std.system.Thorlib;

EXPORT locCluster := MODULE
  /**
    * Return the partially clustered result of performing DBSCAN on points present only
    * in one node. locDBSCAN takes as input a dataset distributed such that all points
    * are available in all nodes, but only whole set of points to form neighbors, resulting
    * in 'local' and 'remote' neighbors. This partial DBSCAN clustering is returned, per node.
    *
    * One of the following distance functions may be used to compute distances between points:
    * "euclidean","cosine","minkowski","manhattan","haversine","chebyshev"
    *
    * Of these, "minkowski" requires an additional parameter called p-value, that must be passed
    * to the function when used
    *
    * @param dsIn          Distributed dataset for clustering in DATASET(l_stage2) format
    * @param eps           The epsilon value for DBSCAN clustering
    * @param minPts        The minimum number of points to form a cluster
    * @param distance_func String naming the distance function to use
    * @param params        Set of additional parameters needed for distance functions
    * @param localNode     Parameter that indicates which node the code is running on
    */
    EXPORT STREAMED DATASET(Files.l_stage3) locDBSCAN(STREAMED DATASET(Files.l_stage2) dsIn,
																											REAL threshold,
                                                      STRING distance_func = 'euclidean',
                                                      SET OF REAL8 params = [],
                                                      UNSIGNED4 localNode = Thorlib.node()
                                                      ) := EMBED(C++ : activity)

    #include<iostream>
    #include<bits/stdc++.h>

    using namespace std;

    string distanceFunc = "euclidian";
    vector<double> dist_params;
    //data structure to represent the data points in a dataset for disjoint sets.
    struct node{
        uint16_t wi;
        uint64_t id;
        uint64_t nodeId;
        vector<float> fields;
        bool ifLocal = false;
        bool ifCore = false;
        node *parent = NULL;
        bool isModified = false;
        bool isVisited = false;
    };
    // distance = (sum((a - b)^2))^(1/2)
    double euclidian(vector<float> a, vector<float> b){
        double sum=0;
        for(uint32_t i=0; i<a.size(); ++i){
            sum += (a[i] - b[i])*(a[i] - b[i]);
        }
        return sqrt(sum);
    }
    // distance = 2*r*sin^-1((sin^2((a-b)/2)+cos(a)*cos(b)*sin^2((x-y)/2))
    // applicable only when size of columns is 2.
    double haversine(vector<float> a, vector<float> b){
        int M=a.size();

        if(M!=2){
            return 0;
        }

        double lat1=a[0];
        double lat2=b[0];
        double lon1=a[1];
        double lon2=b[1];

        double sin_0 = sin(0.5 * (lat1 - lat2));
        double sin_1 = sin(0.5 * (lon1 - lon2));

        return (sin_0 * sin_0 + cos(lat1) * cos(lat2) * sin_1 * sin_1);
    }

    // distance = sum(|a - b|)
    double manhattan(vector<float> a, vector<float> b){
        double ans=0;
        int M=a.size();
        for(int i=0;i<M;i++)
        ans=ans+(abs((a[i])-(b[i])));

        return ans;
    }
    // distance = sum(|a - b|^p)^(1/p)
    double minkowski(vector<float> a, vector<float> b, int p){
        int m=a.size();
        double ans=0;
        for(int i=0;i<m;i++){
                ans+=pow(abs(a[i]-b[i]),p);
        }

        return pow(ans,(double)1/p);
    }

    // distance = ((A.B)/(||A||.||B||))
    double cosine(vector<float> a, vector<float> b){
        double ans=0, a1=0,a2=0;
        int m=a.size();
        for(int i=0;i<m;i++){
                ans+=a[i]*b[i];
                a1=a1+pow(a[i],2);
                a2=a2+pow(b[i],2);
        }
        return ans/(sqrt(a1)*sqrt(a2));
    }
    // distance = max(|x - y|)
    double chebyshev(vector<float> a, vector<float> b){
        int m=a.size();
        float ans=0;
        for(int i=0;i<m;i++){
                ans=max(abs(a[i]-b[i]),ans);
        }
        return ans;
    }
    

    // function: find returns the ultimate parent of the node in tree.
    // input: node * data pointer
    // output: pointer to parent of tree.
    node* find(node *p){
        if(p->parent == NULL || p->parent == p){
            return p;
        } else {
            return find(p->parent);
        }
    }
    // function: Union merges the trees a and b based on disjoint sets
    // input : Two trees(a and b) to merge
    // output: void.
    void Union(vector<node*> ds, node* a, node* b){
        node* x = find(a);
        node* y = find(b);
        if(x->ifCore && !y->ifCore){
            y->parent = x;
            return;
        } else if (!x->ifCore && y->ifCore){
            x->parent = y;
            return;
        }
        if(x == y) return;
        else if(x->id > y->id) y->parent = x;
        else x->parent = y;
    }
		
		
		
    
    bool getNeighbors(vector<node*>ds,vector<float> landmark, vector<double> s2, uint32_t min_pts, vector<double>&kernels, double threshold){

  	uint32_t d = 0;
  	for(uint64_t  i = 0; i < ds.size(); i++){
  		double a = 0.0;
			if(ds[i]->isModified == true||ds[i]->isVisited == true)
				continue;
				double s = 1.0;
				for(uint32_t i = 0; i < s2.size(); i++)
				{
					s *= s2[i];
				}
				double t = 0.9;
		while(t >= threshold)
		{
			for(uint32_t i = 0; i < kernels.size(); i++)
			{
				kernels[i] = 0;
			}
  		for(uint64_t curr_var = 0; curr_var < ds[0]->fields.size(); curr_var++){	
			
			
  			 
				 a += pow((ds[i]->fields[curr_var] - landmark[curr_var]),2);
  		}
			a = exp(-a/(2 * s)); 
			
			if(a >= t)
			kernels[i] = 1;
			else
			kernels[i] = 0;

}  

		
		if(accumulate(kernels.begin(), kernels.end(), 0) >= (int)min_pts)
		{
  	
		return true;
		}
		t = t - 0.05;
		}
	 return false;
}

    //function: dbscan returns a dataset with parentid's in each local node.
    //input: Vector ds, distance eps and number of min points.
    void dbscan(vector<node*> ds, double threshold) {
				uint64_t minpts;
				uint64_t d = ds[0]->fields.size();				
				minpts = 0.1 * ds.size();
				
				uint32_t c  = 0;
	
	vector<double> sum_x_map, sum_x2_map;
	for(uint64_t curr_var = 0;curr_var < ds[0]->fields.size(); curr_var++)
		{
					sum_x_map.push_back(0.0);
					sum_x2_map.push_back(0.0);
					
					for(uint64_t i = 0; i < ds.size(); i++){
							
							sum_x_map[curr_var] += ds[i]->fields[curr_var];
							sum_x2_map[curr_var] += ds[i]->fields[curr_var] * ds[i]->fields[curr_var];			
			}		
		}
		
		vector<double> s2(d,0);
		for(uint64_t curr_var = 0; curr_var < ds[0]->fields.size(); curr_var++)
	{
		double x  = sum_x_map[curr_var]/ds.size();
  	double x2 = sum_x2_map[curr_var];
  	 s2[curr_var] = x2/ds.size() - (x*x);
		}
		
	
				
        for(uint64_t i=0; i<ds.size(); ++i){

            if(!ds[i]->ifLocal) continue;
						
						vector<double> kernels(ds.size(),0);
						bool t = getNeighbors(ds,ds[i]->fields,s2,minpts,kernels,threshold);
						
						
						if(!t)
						{
							ds[i]->isModified = true;

							continue;
						}

						
					vector<node*> neighs;
					
					for(uint32_t j = 0;j < kernels.size();j++)
					{
							if(kernels[j] == 1)
							{
							if(i == j)
							continue;
							neighs.push_back(ds[j]);
							}
					}
        
						   ds[i]->isModified = true;

                ds[i]->ifCore = true;
                ds[i]->parent = NULL;
                for(uint64_t n=0; n < neighs.size(); ++n){
                    neighs[n]->isModified = true;
                    if(neighs[n]->ifLocal){
                        if(neighs[n]->ifCore){
                            Union(ds,ds[i],neighs[n]);
                        } else {
                            if(neighs[n]->isVisited) continue;
                            neighs[n]->isVisited = true;
                            Union(ds,ds[i],neighs[n]);
                        }
                    } else {
                        if(!neighs[n]->ifCore){
												
															vector<double> k;
															
                            if(getNeighbors(ds,neighs[n]->fields,s2,minpts,kernels,threshold)){
                                neighs[n]->ifCore = true;
                                Union(ds,ds[i],neighs[n]);
                            } else {
                                if(neighs[n]->isVisited) continue;
                                neighs[n]->isVisited = true;
                                Union(ds,ds[i],neighs[n]);
                            }
                        } else {
                            Union(ds,ds[i],neighs[n]);
                        }
                    }
                }
            }
        
    }

    // The data structure for the return layout.
    struct retRecord{
    uint32_t wi;
    uint32_t id;
    uint32_t parentId;
    uint32_t nodeId;
    bool if_local;
    bool if_core;
    };
    //ResultStream Interface returns the resulting rows as a stream for global merge phase.
    //Uses retRecord datastructure to store the results of local clustering
    class ResultStream : public RtlCInterface, implements IRowStream {
    public:
        ResultStream(IEngineRowAllocator *_ra, IRowStream *_ds,double threshold,
                                    unsigned long long lnode) : ra(_ra), ds(_ds), Lnode(lnode){

            count = 0;
            while(true){
                const byte * next = (const byte *)ds->nextRow();
                if (!next) break;
                const byte * p = next;
                node temp;
                temp.wi = *((uint16_t*)p); p += sizeof(uint16_t);
                temp.id = *((unsigned long long*)p); p += 2*sizeof(unsigned long long);
                temp.nodeId = *((unsigned long long*)p); p += sizeof(unsigned long long);
                p += sizeof(bool);
                uint32_t lenFields = *((uint32_t*)p);
                p += sizeof(uint32_t);
                for(uint32_t i=0; i<lenFields/sizeof(float); ++i){
                    float f = *((float*)p); p += sizeof(float);
                    temp.fields.push_back(f);
                }
                temp.ifLocal = (lnode == temp.nodeId); p += sizeof(bool);
                temp.ifCore = false;
                dataset.push_back(temp);
                // Release the input row
                rtlReleaseRow(next);
            }

            for(uint64_t i=0; i<dataset.size(); ++i){
                results.push_back(&dataset[i]);
            }

            dbscan(results,threshold);
        }

        //Returning  row by row via Interface
        RTLIMPLEMENT_IINTERFACE
        virtual const void* nextRow() override {
            RtlDynamicRowBuilder rowBuilder(ra);
            if(count < results.size()){
                while(count < dataset.size() && !dataset[count].isModified )
                    count++;

                if(count >= results.size()) return NULL;

                uint32_t lenRec = 4*sizeof(uint32_t) + 2*sizeof(bool);
                byte* p = (byte*)rowBuilder.ensureCapacity(lenRec, NULL);

                *((uint32_t*)p) = dataset[count].wi; p += sizeof(uint32_t);
                *((uint32_t*)p) = Lnode; p += sizeof(uint32_t);
                *((uint32_t*)p) = dataset[count].id; p += sizeof(uint32_t);
                *((uint32_t*)p) = find(&dataset[count])->id; p += sizeof(uint32_t);
                *((bool*)p) = dataset[count].ifLocal; p += sizeof(bool);
                *((bool*)p) = dataset[count].ifCore;

                count++;
                return rowBuilder.finalizeRowClear(lenRec);
            } else {
                return NULL;
            }
        }

        virtual void stop() override{}

    protected:
        Linked<IEngineRowAllocator> ra;
        unsigned count;
        vector<node> dataset;
        vector<node*> results;
        IRowStream *ds;
        uint64_t Lnode;
    };

    #body
    //Main cpp code. Setting the distance function type like 'euclidean','haversine',etc.
    distanceFunc = distance_func;
    double* p = (double*)params;

    for(uint32_t i=0; i<lenParams/sizeof(double); ++i){
        dist_params.push_back(*p);
        p += sizeof(double);
    }
    //converting the input string to lower case by transform.
    transform(distanceFunc.begin(),distanceFunc.end(),distanceFunc.begin(),::tolower);

    return new ResultStream(_resultAllocator, dsin,threshold,localnode);
  ENDEMBED;//end locDBSCAN

END;