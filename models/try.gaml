/**
* Name: ABCDdriving
* Author: skbhamidipati
* Description: Describe here the model and its experiments
* Tags: Tag1, Tag2, TagN
*/


model ABCDdriving
import "classify.gaml"


global {
	/** Insert the global definitions, variables and actions here */
	// READ PHYSICAL ENVIRONMENT
	float step <- 1 # mn;
	file NL_mainroads_shape <- file("../includes/NL/ActueleWegenlijst.shp");
	file NL_postcodes_shape <- file("../includes/NL/pcPoints.shp");
	file simplePostCode <- file("../includes/NL/NL_PCstats.shp");
	
	geometry shape <-envelope(simplePostCode);
	
	// READ AGENT ATTRIBUTES FROM NATIONAL SURVEY
	
	file my_csv_file <- csv_file("../doc/aidwork1.csv", ",");
	matrix population <- matrix(my_csv_file);
	map answers <- user_input("Number of Residents to Generate from National Survey", ["Number of residents"::""]);
	int Number_of_residents <- int(answers["Number of residents"]);
	
	init{
		write gauss(0,1);
		create driving_roads from:NL_mainroads_shape;
	//	create driving_pointShape from:NL_postcodes_shape with:[pc::int(read("PPC")),xdag::int(read("XDAG")),xndag::int(read("XNDAG")),xarb::int(read("XARB")), xpop::int(read("XPOP"))];
		create driving_pc_polygons from:simplePostCode with:[pc::int(read("PPC")),xdag::int(read("XDAG")),xndag::int(read("XNONDAG")),xarb::int(read("XARB")), xpop::int(read("XPOP")),
					ddag::float(read("DDAG")),dndag::float(read("DNONDAG")),darb::float(read("DARB")), dpop::float(read("DPOP"))		];
		
		create driving_people number:Number_of_residents{
			myPC <- one_of(driving_pc_polygons) ;
			location <- any_location_in(myPC); 
			albatross_Xdag<-world.classify_xdag(myPC.xdag);
			albatross_Xndag<-world.classify_xndag(myPC.xndag);
			albatross_Xarb<-world.classify_xarb(myPC.xarb);
			albatross_Xpop<-world.classify_xpop(myPC.xpop);
			albatross_Ddag<-world.classify_ddag(myPC.ddag);
			albatross_Dndag<-world.classify_dndag(myPC.dndag);
			albatross_Darb<-world.classify_darb(myPC.darb);
			albatross_Dpop<-world.classify_dpop(myPC.dpop);
			
			
		}
	}
	
	reflex initialState when:cycle=1{
		ask driving_people{
			save [name,int(self)] to:"export.csv" type:csv header:true  ;
		}
		
	}
}

species driving_pc_polygons{
	rgb colors<-#red;
	int pc;
	int xdag;
	int xndag;
	int xarb;
	int xpop;
	
	float ddag;
	float dndag;
	float darb;
	float dpop;
	aspect a{
		draw shape color:rgb(#lightgray,0.4) empty:false ;
	}
}

species driving_pointShape{
	
	aspect a{
		draw shape color:#red;
		//draw string(xdag) color:#black font:font('Helvetica Neue',8, #bold + #italic);
	}
}

species driving_roads {
	aspect a{
		draw shape width:1 color:#lightgray;
	}
	
}
species driving_people skills:[moving]{
	
	//aidwork1
	
	int albatross_Urb   ; // hh urb
	int albatross_Comp   ; //hh composition
	int albatross_Child  ; //hh
	int albatross_Day;    // day of week, hh ... day
	int albatross_pAge   ; // partner age
	
	
	int albatross_SEC; // hh. sec
	int albatross_Ncar   ; //hh numcars
	int albatross_Gend   ; // mem gender
	
	int albatross_Driver ; // mem license
	int albatross_wstat  ; // mem work
	int albatross_Pwstat; // partner.  work
	
	//aidwork2
	
	int albatross_Xdag   ; // based on hh location and is derived
	int albatross_Xndag ; // hh based on hh location and is derived
	int albatross_Xarb  ; // hh based on hh location and is derived
	int albatross_Xpop  ; // hh based on hh location and is derived
	
	int albatross_Ddag  ; // hh based on hh location and is derived
	int albatross_Dndag ; // hh based on hh location and is derived
	int albatross_Darb ;  //location hh derived
	int albatross_Dpop   ; //based on hh location and is derived
	
	
	
	//aidwork3
	int albatross_Dur 	; // not needed  
	
	driving_pc_polygons myPC;
	list<driving_pointShape> forXdag;
	list<driving_pointShape> forXndag;
	
	init{
		
		// GET SOCIO-ECONOMIC CHARACTERISTICS FROM NATIONAL SURVEY
		list requested_population <- one_of(sample(rows_list(population), 1, false));
			//write requested_population;
			//write requested_population[2];
			//aidwork1
			albatross_Urb <- int(requested_population[0]);
			albatross_Comp <- int(requested_population[1]) ;
			albatross_Child <- int(requested_population[2]) ;
			albatross_Day <- int(requested_population[3]) ;
			albatross_pAge <- int(requested_population[4]) ;
			albatross_SEC <- int(requested_population[5]) ;
			albatross_Ncar <- int(requested_population[6]) ;
			albatross_Gend <- int(requested_population[7]) ;
			albatross_Driver <- int(requested_population[8]) ;
			albatross_wstat <- int(requested_population[9]) ;
			albatross_Pwstat <- int(requested_population[10]) ;
			
			// GET SITUATIONAL CHARACTERISTICS FROM SHAPEFILES
			
			do assess_my_situational_characteristics();
		
		
	}
	
	action assess_my_situational_characteristics{
		 
		 
	}
	
	
	
	aspect a{
		draw circle(300) color:#green;
		draw circle(3100) color:rgb(#red,0.2);
	}
}

experiment ABCDdriving type: gui {
	/** Insert here the definition of the input and output of the model */
	output {
		display first type:java2D{
			species driving_pc_polygons aspect:a;
			species driving_people aspect:a;
			
			species driving_roads aspect:a ;
			species driving_pointShape aspect:a;
		}
		display focussed type:opengl camera_pos:{driving_pc_polygons(320).location.x, driving_pc_polygons(320).location.y, 125000} camera_look_pos:{driving_pc_polygons(320).location.x, driving_pc_polygons(320).location.y, 50} {
			//focus_on driving_pc_polygons(320);
			species driving_pc_polygons aspect:a ;
			species driving_people aspect:a;
			species driving_pointShape aspect:a;
			species driving_roads aspect:a ;
			
		}
	}
}
