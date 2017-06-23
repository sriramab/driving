/**
* Name: ABCDdriving
* Author: skbhamidipati
* Description: Describe here the model and its experiments
* Tags: Tag1, Tag2, TagN
*/


model ABCDdriving
import "functions.gaml"


global {
	/** Insert the global definitions, variables and actions here */
	// DEFINE SIMULATION STEP SIZE
	float step <- 15 # mn;
	
	// READ PHYSICAL ENVIRONMENT
	file NL_mainroads_shape <- file("../includes/NL/ActueleWegenlijst.shp");
	file NL_postcodes_shape <- file("../includes/NL/pcPoints.shp");
	file simplePostCode <- file("../includes/NL/NL_PCstats.shp");
	
	// DEFINE SHAPE OF THE EXPERIMENT
	geometry shape <-envelope(simplePostCode);
	
	// READ AGENT ATTRIBUTES FROM NATIONAL SURVEY
	file my_csv_file <- csv_file("../includes/aidwork1.csv", ",");
	matrix population <- matrix(my_csv_file);
	map<string, unknown> answers <- user_input("Number of Residents to Generate from National Survey", ["How many Number of residents?"::"", "Put them in which Postcode?"::""]);
	int Number_of_residents <- int(answers["How many Number of residents?"]);
	int put_in_postcode <-int(answers["Put them in which Postcode?"]);
	
	list<map> Decisions;
	
	init{
		write gauss(0,1);
		create driving_roads from:NL_mainroads_shape;
	//	create driving_pointShape from:NL_postcodes_shape with:[pc::int(read("PPC")),xdag::int(read("XDAG")),xndag::int(read("XNDAG")),xarb::int(read("XARB")), xpop::int(read("XPOP"))];
		create driving_pc_polygons from:simplePostCode with:[pc::int(read("PPC")),xdag::int(read("XDAG")),xndag::int(read("XNONDAG")),xarb::int(read("XARB")), xpop::int(read("XPOP")),
					ddag::float(read("DDAG")),dndag::float(read("DNONDAG")),darb::float(read("DARB")), dpop::float(read("DPOP"))		];
		
		create driving_people number:Number_of_residents{
			
			
			
			
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
			
			
			
			if is_number(put_in_postcode) and (put_in_postcode)!=0{
				// use this next two lines if you want to place agents as per request of the user
			myPC <- first(driving_pc_polygons where (each.pc=put_in_postcode));
			location <- any_location_in(myPC);
			} 
			else {//use this next two lines if you want to place agents randomly
			myPC <- one_of(driving_pc_polygons);
			location <- any_location_in(myPC);
			
			}
			
			//ASSIGN SITUATIONAL ATTRIBUTES TO AGENTS ONCE THEY HAVE A LOCATION
			albatross_Xdag<-world.classify_xdag(myPC.xdag);
			albatross_Xndag<-world.classify_xndag(myPC.xndag);
			albatross_Xarb<-world.classify_xarb(myPC.xarb);
			albatross_Xpop<-world.classify_xpop(myPC.xpop);
			albatross_Ddag<-world.classify_ddag(myPC.ddag);
			albatross_Dndag<-world.classify_dndag(myPC.dndag);
			albatross_Darb<-world.classify_darb(myPC.darb);
			albatross_Dpop<-world.classify_dpop(myPC.dpop);
			//save [albatross_Darb] to:"../R/useTrees/1.csv" type:csv header:true;
			
			write build_d1_parameters(self);
			
					
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///																					     ///
	///								DECISION TREES										     ///
	///																					     ///
	///    START - ACTION LIST TO GET KEY VALUES TO MATCH THE DECISION TREE AS RECOMMENED BY AUKE         ///
    ///																					     ///
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	string build_d1_parameters(driving_people d){
		string d1 <- string(d.albatross_Urb)+string(d.albatross_Comp)+string(d.albatross_Child)+
		string(d.albatross_Day) +string(d.albatross_pAge)+string(d.albatross_SEC)+string(d.albatross_Ncar)+
		string(d.albatross_Gend)+string(d.albatross_Driver) + string(d.albatross_wstat)+ string(d.albatross_Pwstat)+
		string(d.albatross_Xdag)+string(d.albatross_Xndag)+string(d.albatross_Xarb)+string(d.albatross_Xpop)+
		string(d.albatross_Ddag)+string(d.albatross_Dndag)+string(d.albatross_Darb)+string(d.albatross_Dpop);
		return d1;
	}
	
	string build_d2_parameters(driving_people d){
		string d2 <- string(d.albatross_Urb)+string(d.albatross_Comp)+string(d.albatross_Child)+
		string(d.albatross_Day) +string(d.albatross_pAge)+string(d.albatross_SEC)+string(d.albatross_Ncar)+
		string(d.albatross_Gend)+string(d.albatross_Driver) + string(d.albatross_wstat)+ string(d.albatross_Pwstat)+
		string(d.albatross_Xdag)+string(d.albatross_Xndag)+string(d.albatross_Xarb)+string(d.albatross_Xpop)+
		string(d.albatross_Ddag)+string(d.albatross_Dndag)+string(d.albatross_Darb)+string(d.albatross_Dpop);
		return d2;
	} 
	
	string build_d3_parameters(driving_people d){
		string d3 <- string(d.albatross_Urb)+string(d.albatross_Comp)+string(d.albatross_Child)+
		string(d.albatross_Day) +string(d.albatross_pAge)+string(d.albatross_SEC)+string(d.albatross_Ncar)+
		string(d.albatross_Gend)+string(d.albatross_Driver) + string(d.albatross_wstat)+ string(d.albatross_Pwstat)+
		string(d.albatross_Xdag)+string(d.albatross_Xndag)+string(d.albatross_Xarb)+string(d.albatross_Xpop)+
		string(d.albatross_Ddag)+string(d.albatross_Dndag)+string(d.albatross_Darb)+string(d.albatross_Dpop);
		return d3;
	}
	
	string build_d4_parameters(driving_people d){
		string d4 <- string(d.albatross_Urb)+string(d.albatross_Comp)+string(d.albatross_Child)+
		string(d.albatross_Day) +string(d.albatross_pAge)+string(d.albatross_SEC)+string(d.albatross_Ncar)+
		string(d.albatross_Gend)+string(d.albatross_Driver) + string(d.albatross_wstat)+ string(d.albatross_Pwstat)+
		string(d.albatross_Xdag)+string(d.albatross_Xndag)+string(d.albatross_Xarb)+string(d.albatross_Xpop)+
		string(d.albatross_Ddag)+string(d.albatross_Dndag)+string(d.albatross_Darb)+string(d.albatross_Dpop);
		return d4;
	}
	
	string build_d5_parameters(driving_people d){
		string d5 <- string(d.albatross_Urb)+string(d.albatross_Comp)+string(d.albatross_Child)+
		string(d.albatross_Day) +string(d.albatross_pAge)+string(d.albatross_SEC)+string(d.albatross_Ncar)+
		string(d.albatross_Gend)+string(d.albatross_Driver) + string(d.albatross_wstat)+ string(d.albatross_Pwstat)+
		string(d.albatross_Xdag)+string(d.albatross_Xndag)+string(d.albatross_Xarb)+string(d.albatross_Xpop)+
		string(d.albatross_Ddag)+string(d.albatross_Dndag)+string(d.albatross_Darb)+string(d.albatross_Dpop);
		return d5;
	}
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///																					     ///
	///								DECISION TREES										     ///
	///																					     ///
	///    END - ACTION LIST TO GET KEY VALUES TO MATCH THE DECISION TREE AS RECOMMENED BY AUKE             ///
    ///																					     ///
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	aspect a{
		draw circle(300) color:#green;
		draw circle(3100) color:rgb(#red,0.2);
	}
}

experiment ABCDdriving type: gui {
	/** Insert here the definition of the input and output of the model */
	output {
		display first type:java2D  focus:is_number(put_in_postcode) and (put_in_postcode)!=0?(first(driving_pc_polygons where (each.pc=put_in_postcode))):world.shape{
			species driving_pc_polygons aspect:a;
			species driving_people aspect:a;
			
			species driving_roads aspect:a ;
			species driving_pointShape aspect:a;
		}
		
	}
}
