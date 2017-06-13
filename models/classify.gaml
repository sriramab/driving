/**
* Name: classify
* Author: skbhamidipati
* Description: 
* Tags: Tag1, Tag2, TagN
*/

model classify

/* Insert your model definition here */

global{
	
	int classify_xdag(int i){
		int r;
		switch i {
			match_between [0, 114] {r <-0; return r;}
			match_between [115, 252] {r <-1; return r;}
			match_between [253, 306] {r <-2; return r;}
			match_between [307, 506] {r <-3; return r;}
			match_between [507, 675] {r <-4; return r;}
			match_between [676, 100000] {r <-5; return r;}
			
		}
		
	}
	
	int classify_xndag(int i){
		int r;
		switch i {
			match_between [0, 395] {r <-0; return r;}
			match_between [396, 635] {r <-1; return r;}
			match_between [636, 762] {r <-2; return r;}
			match_between [763, 938] {r <-3; return r;}
			match_between [939, 2525] {r <-4; return r;}
			match_between [2525, 100000] {r <-5; return r;}
			
		}
		
	}
	
	int classify_xarb(int i){
		int r;
		switch i {
			match_between [0, 8785] {r <-0; return r;}
			match_between [8786, 12995] {r <-1; return r;}
			match_between [12996, 16120] {r <-2; return r;}
			match_between [16121, 20199] {r <-3; return r;}
			match_between [20200, 70314] {r <-4; return r;}
			match_between [70315, 1000000] {r <-5; return r;}
			
		}
		
	}
	
	int classify_xpop(int i){
		int r;
		switch i {
			match_between [0, 5050] {r <-0; return r;}
			match_between [5051, 8845] {r <-1; return r;}
			match_between [8846, 13217] {r <-2; return r;}
			match_between [13218, 16833] {r <-3; return r;}
			match_between [16834, 22884] {r <-4; return r;}
			match_between [22885, 1000000] {r <-5; return r;}
			
		}
		
	}
	
	
	int classify_ddag(float i){
		int r;
		switch i {
			match_between [0, 71.9] {r <-0; return r;}
			match_between [72, 127.9] {r <-1; return r;}
			match_between [128, 165.9] {r <-2; return r;}
			match_between [166, 202.9] {r <-3; return r;}
			match_between [203, 346.9] {r <-4; return r;}
			match_between [347, 10000] {r <-5; return r;}
			
		}
		
	}
	
	
	
	int classify_dndag(float i){
		int r;
		switch i {
			match_between [0, 92.9] {r <-0; return r;}
			match_between [93, 145.9] {r <-1; return r;}
			match_between [146, 176.9] {r <-2; return r;}
			match_between [177, 258.9] {r <-3; return r;}
			match_between [259, 334.9] {r <-4; return r;}
			match_between [335, 10000] {r <-5; return r;}
			
		}
		
	}
	
	
	int classify_darb(float i){
		int r;
		switch i {
			match_between [0, 91.9] {r <-0; return r;}
			match_between [92, 127.9] {r <-1; return r;}
			match_between [128, 200.9] {r <-2; return r;}
			match_between [201, 273.9] {r <-3; return r;}
			match_between [274, 359.9] {r <-4; return r;}
			match_between [360, 10000] {r <-5; return r;}
			
		}
		
	}
	
	int classify_dpop(float i){
		int r;
		switch i {
			match_between [0, 0.9] {r <-0; return r;}
			match_between [1, 104.9] {r <-1; return r;}
			match_between [105, 125.9] {r <-2; return r;}
			match_between [126, 162.9] {r <-3; return r;}
			match_between [163, 277.9] {r <-4; return r;}
			match_between [278, 10000] {r <-5; return r;}
			
		}
		
	}
	
	int classify_dur(float i){
		int r;
		switch i {
			match_between [0, 384.9] {r <-0; return r;}
			match_between [385, 489.9] {r <-1; return r;}
			match_between [490, 524.9] {r <-2; return r;}
			match_between [525, 559.9] {r <-3; return r;}
			match_between [560, 10000] {r <-4; return r;}
			
			
		}
		
	}
	
	
	
	
	init{
		int k <- classify_xdag(133);
		write k;

	}

}


experiment name type: gui {

	
	// Define parameters here if necessary
	// parameter "My parameter" category: "My parameters" var: one_global_attribute;
	
	// Define attributes, actions, a init section and behaviors if necessary
	// init { }
	
	
	output {
	// Define inspectors, browsers and displays here
	
	// inspect one_or_several_agents;
	//
	// display "My display" { 
	//		species one_species;
	//		species another_species;
	// 		grid a_grid;
	// 		...
	// }

	}
}