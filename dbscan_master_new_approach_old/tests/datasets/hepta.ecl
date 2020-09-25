﻿EXPORT hepta := module

EXPORT layout := RECORD
		REAL X;
		REAL Y;
		real z;
	END;

export ds := dataset([{-0.000731,0.048211000000000004,0.069198},
{-0.060766999999999995,-0.00908,0.053085},
{0.013252000000000002,-0.011876000000000001,0.055324},
{-0.054508,-0.0038130000000000004,0.001738},
{0.02418,0.068275,0.033462},
{-0.029307999999999997,0.059849,-0.06326},
{-0.016453,0.013881000000000001,-0.013236000000000001},
{-0.042361,-0.059941999999999995,-0.026487},
{-0.016309999999999998,-0.036612,0.047928},
{0.03536,-0.04495,0.041474000000000004},
{-0.00028700000000000004,-0.049496,-0.06343},
{-0.06593099999999999,-0.005381,-0.064899},
{0.009049,0.027975999999999997,0.01198},
{-0.005335,0.062592,-0.057507},
{-0.004175,0.06464600000000001,0.040856},
{0.09102400000000001,-0.031445999999999995,-0.014774},
{-0.077068,-0.035324,-0.039060000000000004},
{0.05515,-0.007045,0.07849500000000001},
{-0.033779,0.049066000000000005,0.026958},
{0.044954,-0.033716,0.011894},
{0.008785,0.016895,-0.09079},
{-0.061654999999999995,-0.023084999999999998,0.007996},
{-0.051274,0.054634,0.032257},
{0.04421,-0.062216999999999995,-0.018733},
{-0.003343,0.069586,0.069452},
{-0.064487,0.012217,0.040873},
{0.042168000000000004,-0.009972,0.047962},
{-0.06149500000000001,0.059835,0.025843},
{0.071795,-0.01526,-0.023346000000000002},
{0.05873300000000001,-0.029135,-0.011720999999999999},
{0.078178,-0.014786,-0.00032},
{2.418463,0.49012700000000003,0.033581},
{2.805184,0.769746,-0.557435},
{2.983722,-0.983118,-0.165216},
{3.055291,-0.477796,0.37052399999999996},
{3.015527,-0.666039,0.126169},
{2.449981,0.17566600000000002,-0.531892},
{3.199806,0.201051,0.5867600000000001},
{3.266405,0.012518000000000001,-0.761892},
{3.7477099999999997,-0.41696000000000005,0.148884},
{3.4118489999999997,0.5166649999999999,-0.702665},
{3.733854,0.184758,0.482416},
{3.59214,-0.371411,-0.673235},
{3.5935099999999998,0.125884,0.277346},
{2.387269,0.784515,-0.011033},
{3.4237910000000005,-0.039296,0.06665399999999999},
{2.425059,-0.20682199999999998,-0.263965},
{2.407337,-0.015134,0.097093},
{2.923991,-0.262388,-0.672982},
{3.1882029999999997,-0.47637700000000005,0.051427},
{2.377023,0.498033,-0.382225},
{2.610067,0.787375,0.046041000000000006},
{2.9188259999999997,-0.8296,-0.198249},
{2.9328529999999997,0.7197279999999999,-0.347704},
{3.47194,0.322667,0.25301999999999997},
{3.266172,0.207763,0.078446},
{2.916963,-0.636281,-0.45965500000000004},
{3.020822,-0.49173900000000004,0.382338},
{2.844004,-0.078753,-0.6605880000000001},
{2.826876,-0.241459,-0.143806},
{2.7715110000000003,0.36275100000000005,-0.669945},
{-2.69712,0.342837,0.29685500000000004},
{-2.57583,-0.752408,-0.22582800000000003},
{-3.308062,0.9194030000000001,-0.091698},
{-3.970394,-0.017968,0.097194},
{-3.3320260000000004,-0.22133000000000003,-0.41087299999999993},
{-2.679173,0.521163,0.033068},
{-2.186732,-0.536953,-0.08932999999999999},
{-3.013009,-0.082401,-0.750346},
{-3.464085,0.458797,-0.745681},
{-2.632916,0.683901,-0.153258},
{-3.315788,0.017903,0.7030270000000001},
{-2.833584,-0.684569,0.298511},
{-2.722148,-0.502344,0.24500300000000003},
{-2.608905,0.443179,0.44754099999999997},
{-2.853364,-0.788934,-0.276868},
{-2.809655,-0.092462,0.719525},
{-3.538035,0.777137,0.091226},
{-2.457811,-0.601538,0.548791},
{-2.762541,-0.5409109999999999,0.251193},
{-2.929594,-0.162338,0.42795900000000003},
{-3.054864,-0.22074899999999997,0.8588530000000001},
{-3.632051,-0.045369,0.497112},
{-3.595796,-0.25031,-0.26069000000000003},
{-2.285053,0.11154700000000001,0.6528470000000001},
{-2.664311,-0.035719,0.357768},
{-3.163578,0.28680500000000003,-0.843201},
{-2.599157,0.438496,0.094013},
{-3.381994,0.308228,-0.689706},
{-3.9610309999999997,-0.111044,0.022821},
{-2.827045,-0.074139,0.5413600000000001},
{0.49813500000000005,2.895371,0.7868430000000001},
{0.21843600000000002,3.0675380000000003,0.030236000000000002},
{0.135451,2.12925,0.32024600000000003},
{0.42011800000000005,3.055572,0.23061700000000002},
{0.6598649999999999,3.4463169999999996,-0.10145499999999999},
{0.619487,3.285343,0.27827399999999997},
{-0.29420799999999997,3.2968879999999996,-0.17435699999999998},
{-0.362217,2.6571119999999997,0.01996},
{-0.561919,3.334167,0.068536},
{0.186843,3.7066879999999998,-0.259004},
{0.450086,2.844335,0.073905},
{-0.047549,3.6345620000000003,0.613045},
{0.432449,3.7744949999999995,0.096256},
{0.444504,3.491508,-0.745843},
{-0.116409,2.6188860000000003,0.576378},
{-0.601582,3.5484970000000002,0.101766},
{0.268449,3.6620730000000004,-0.10373900000000001},
{-0.007967,2.91813,0.390422},
{-0.811876,2.976918,-0.40471},
{-0.003684,2.460306,0.323449},
{0.27221,2.2874689999999998,-0.243128},
{-0.003839,3.107724,-0.876719},
{0.17535699999999999,3.7152489999999996,0.344842},
{-0.35017800000000004,2.515348,0.695052},
{0.016665,2.986915,-0.265349},
{0.39417800000000003,2.772903,0.5830350000000001},
{0.715985,3.467443,-0.17113699999999998},
{0.28994000000000003,2.60696,0.767379},
{0.854454,2.8952310000000003,-0.335877},
{0.308424,3.293211,-0.383773},
{-0.154151,-2.382802,-0.552876},
{0.042376,-3.013402,0.26318},
{0.7640600000000001,-2.974825,0.30490900000000004},
{0.273431,-3.5490449999999996,0.602433},
{0.109072,-2.872739,-0.972276},
{-0.6090270000000001,-2.316553,0.05604},
{0.563714,-2.668933,0.27222199999999996},
{0.053112,-3.6948300000000005,-0.446254},
{0.374246,-3.881493,-0.178669},
{-0.25540999999999997,-2.573785,-0.369218},
{-0.05832999999999999,-3.5398769999999997,0.156878},
{0.43680399999999997,-2.8490580000000003,-0.7058220000000001},
{-0.185927,-2.83419,-0.8713059999999999},
{-0.15729,-3.0352419999999998,-0.447355},
{-0.253287,-2.355499,0.53801},
{0.8563379999999999,-2.928918,-0.10524700000000001},
{-0.448767,-2.8925669999999997,0.036683999999999994},
{-0.763126,-3.121529,0.012815},
{0.50729,-3.69845,-0.126832},
{-0.262387,-2.7936,0.893868},
{0.638189,-2.885896,-0.535134},
{-0.715655,-3.174318,-0.41544200000000003},
{-0.148243,-2.3487419999999997,-0.198939},
{-0.436461,-3.1896139999999997,-0.874082},
{-0.015747,-3.6014690000000003,0.678772},
{-0.38032699999999997,-2.120669,-0.201018},
{-0.078679,-2.969195,-0.085163},
{0.725907,-2.642703,-0.392598},
{-0.11851199999999999,-2.3916619999999997,-0.11685699999999999},
{0.378156,-3.7424739999999996,0.42604},
{-0.646687,-0.257803,2.8790259999999996},
{0.862612,-0.25709699999999996,3.3396220000000003},
{0.58395,0.25261999999999996,3.164447},
{-0.106313,0.539686,3.3624300000000003},
{-0.447773,-0.165269,2.3954619999999998},
{0.278688,-0.6785100000000001,3.0190650000000003},
{-0.49995900000000004,-0.102398,2.918835},
{0.628733,-0.136098,2.9616689999999997},
{-0.5507770000000001,0.820583,2.888145},
{0.280057,-0.332023,2.280202},
{-0.6814899999999999,-0.388565,2.852309},
{-0.150402,0.774676,3.236697},
{-0.175775,0.816718,2.810907},
{0.40849,-0.752991,2.708342},
{-0.6876869999999999,0.5331,2.864252},
{0.187892,0.099277,3.3971},
{0.40274,0.309218,2.1847209999999997},
{-0.333692,0.726125,2.755337},
{-0.073884,0.8566729999999999,3.449364},
{0.074276,-0.44986000000000004,2.289555},
{-0.234023,0.508787,2.627695},
{0.33853,-0.722352,2.402052},
{0.777033,0.217745,2.671151},
{0.093523,0.595698,3.532532},
{0.21594499999999997,-0.323846,2.195408},
{-0.031152,0.385966,3.106696},
{0.26075,0.391448,2.176698},
{-0.542543,0.386463,2.917456},
{-0.306005,-0.9159579999999999,2.884296},
{-0.11441400000000002,0.026251,3.8993889999999998},
{-0.749873,0.616942,-2.862605},
{-0.10815699999999999,-0.083104,-3.909294},
{-0.41089799999999993,0.46721599999999996,-3.64399},
{0.662499,-0.378195,-2.900845},
{-0.057589,0.548771,-3.0720259999999997},
{0.64518,-0.27658499999999997,-2.877792},
{0.257191,0.114881,-2.929682},
{-0.16911900000000002,0.400328,-2.8532990000000003},
{0.228327,-0.513736,-3.600658},
{-0.512238,0.372109,-3.357134},
{-0.510091,-0.6178060000000001,-3.5438959999999997},
{-0.001328,0.27527399999999996,-2.367165},
{-0.086874,0.13808399999999998,-3.152736},
{-0.558094,-0.138533,-2.7318290000000003},
{0.640575,-0.52869,-2.8825790000000002},
{0.033866,0.30142399999999997,-2.949164},
{-0.530334,0.571733,-3.1222790000000002},
{0.488731,0.6822600000000001,-3.026392},
{-0.320178,-0.530404,-2.430535},
{0.143306,0.5787260000000001,-3.657507},
{-0.36578,-0.491918,-2.483666},
{0.660425,-0.25953699999999996,-3.671958},
{0.647696,0.44422,-2.807808},
{-0.110876,0.163359,-3.038903},
{-0.694187,0.258777,-2.411717},
{0.175738,-0.053478,-2.733752},
{0.396046,-0.8583770000000001,-3.126866},
{-0.406362,-0.334541,-2.885598},
{-0.299275,0.071281,-3.642585},
{-0.506192,0.43353800000000003,-2.608597}],layout);

end;