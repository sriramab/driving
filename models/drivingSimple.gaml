/**
* Name: ABCDdriving
* Author: skbhamidipati
* Description: Describe here the model and its experiments
* Tags: Tag1, Tag2, TagN
*/
model ABCDdriving

import "functions.gaml"


global
{
/** Insert the global definitions, variables and actions here */

// DEFINE SIMULATION STEP SIZE, HOUR , DAY OF THE WEEK AND TOTAL DAYS
	float step <- 15 # mn;
	float currentTime <- time;
	
	int hour_of_day <- (int(time / 3600)) mod 23 update: (int(time / 3600)) mod 23; //function:{(int(time/3600)) mod 23};
	int day_of_week <- int(time / (3600 * 24)) mod 7 update: int(time / (3600 * 24)) mod 7; //function:{int(time/(3600*24)) mod 6 };
	int totalDays <- int(time / (3600 * 24)) update: int(time / (3600 * 24)); //function:{int(time/(3600*24))};

	// READ PHYSICAL ENVIRONMENT
	file NL_mainroads_shape <- file("../includes/NL/NLtraced.shp");
	//file NL_postcodes_shape <- file("../includes/NL/pcPoints.shp");
	file simplePostCode <- file("../includes/NL/NL_PCstats.shp");

	// DEFINE SHAPE OF THE EXPERIMENT
	geometry shape <- envelope(simplePostCode);

	// DEFINE ROAD AS A GRAPH
	graph the_graph;

	// READ AGENT ATTRIBUTES FROM NATIONAL SURVEY
	file my_csv_file <- csv_file("../includes/aidwork1.csv", ",");
	matrix population <- matrix(my_csv_file);
	map<string, unknown> answers <- user_input("Number of Residents to Generate from National Survey", ["How many Number of residents?"::"", "Put them in which Postcode?"::""]);
	int Number_of_residents <- int(answers["How many Number of residents?"]);
	int put_in_postcode <- int(answers["Put them in which Postcode?"]);
	list<map> Decisions;
	init
	{
		//write gauss(0, 1);
		create driving_roads from: NL_mainroads_shape;
		//	create driving_pointShape from:NL_postcodes_shape with:[pc::int(read("PPC")),xdag::int(read("XDAG")),xndag::int(read("XNDAG")),xarb::int(read("XARB")), xpop::int(read("XPOP"))];
		create driving_pc_polygons from: simplePostCode with:
		[pc::int(read("PPC")), xdag::int(read("XDAG")), xndag::int(read("XNONDAG")), xarb::int(read("XARB")), xpop::int(read("XPOP")), 
			ddag::float(read("DDAG")), dndag::float(read("DNONDAG")), darb::float(read("DARB")), dpop::float(read("DPOP")), horeca::int(read("HORECA"))
		];
		create driving_people number: Number_of_residents
		{
			
		}
		the_graph <- as_edge_graph(NL_mainroads_shape);

	}

//	reflex time_scale
//	{
//		write "hour of day: " + hour_of_day;
//		write "day of week: " + day_of_week;
//		write "total_time: " + totalDays;
//	}

}

species driving_pc_polygons
{
	rgb colors <- # red;
	int pc;
	int xdag;
	int xndag;
	int xarb;
	int xpop;
	float ddag;
	float dndag;
	float darb;
	float dpop;
	int horeca;
	int workingday<-day_of_week update:day_of_week;
	aspect a
	{
		draw shape color: (day_of_week > 5) ? rgb(# orange, 0.4) : rgb(#green, 0.4) empty: false;
	}

}

species driving_pointShape
{
	aspect a
	{
		draw shape color: # red;
		//draw string(xdag) color:#black font:font('Helvetica Neue',8, #bold + #italic);
	}

}

species driving_roads
{
	aspect a
	{
		draw shape width: 1 color: # lightgray;
	}

}

species driving_people skills: [moving] control: fsm
{

//MOVING CHARACTERISITICS 
	float speed <- 70 + rnd(1) * 20 # km / # h; //speeds from 50 to 90 kmph
	float speed_mps <- speed/3.6;// meters per second

	// DAY EBHAVIOR = true(monday:0, tuesday:1, wednesday:2, thursday:3, friday:4); false(saturday:5, sunday:6)
	bool weekday_behavior <- true update: (day_of_week > 5) ? false : true;
	bool _I_am_working_today <- false;
	bool _I_have_a_nonWork_trip <- false;
	bool _do_I_work_within_my_municipality <- true;
	bool _Is_it_full_time;
	float _my_distance_to_work_today;
	//float _my_fixed_distance_to_work;
	
	int _leave_home_for_office_in_cycle;
	int _leave_work_at_cycle;
	int _leave_leisure_at_cycle;
	
	driving_pc_polygons _my_workplace;
	geometry my_link;
	int time_left_afterWork_incycles;
	
	int _time_taken_to_home_from_work_in_cycles;
	int _time_to_leisure_location_in_cycles;
	
	driving_pc_polygons _leisure_location;
	float _leisure_distance;
	list<point> _consequent_next_activity_location;
	list<int> _current_activity_endtime;
	
	float risk_factor<-2.0- rnd(1.0);

	//aidwork1
	int albatross_Urb; // hh urb
	int albatross_Comp; //hh composition
	int albatross_Child; //hh
	int albatross_Day; // day of week, hh ... day
	int albatross_pAge; // partner age
	int albatross_SEC; // hh. sec
	int albatross_Ncar; //hh numcars
	int albatross_Gend; // mem gender
	int albatross_Driver; // mem license
	int albatross_wstat; // mem work
	int albatross_Pwstat; // partner.  work

	//aidwork2
	int albatross_Xdag; // based on hh location and is derived
	int albatross_Xndag; // hh based on hh location and is derived
	int albatross_Xarb; // hh based on hh location and is derived
	int albatross_Xpop; // hh based on hh location and is derived
	int albatross_Ddag; // hh based on hh location and is derived
	int albatross_Dndag; // hh based on hh location and is derived
	int albatross_Darb; //location hh derived
	int albatross_Dpop; //based on hh location and is derived


	//aidwork3
	int albatross_Dur; // not needed  
	driving_pc_polygons myPC;
	point my_home_location;
	list<driving_pointShape> forXdag;
	list<driving_pointShape> forXndag;
	init
	{

	// GET SOCIO-ECONOMIC CHARACTERISTICS FROM NATIONAL SURVEY
		list requested_population <- one_of(sample(rows_list(population), 1, false));
		albatross_Urb <- int(requested_population[0]);
		albatross_Comp <- int(requested_population[1]);
		albatross_Child <- int(requested_population[2]);
		albatross_Day <- int(requested_population[3]);
		albatross_pAge <- int(requested_population[4]);
		albatross_SEC <- int(requested_population[5]);
		albatross_Ncar <- int(requested_population[6]);
		albatross_Gend <- int(requested_population[7]);
		albatross_Driver <- int(requested_population[8]);
		albatross_wstat <- int(requested_population[9]);
		albatross_Pwstat <- int(requested_population[10]);
		if is_number(put_in_postcode) and (put_in_postcode) != 0
		{
		// use this next two lines if you want to place agents as per request of the user
			myPC <- first(driving_pc_polygons where (each.pc = put_in_postcode));
			location <- any_location_in(myPC);
			my_home_location <- location;
		} else
		{ //use this next two lines if you want to place agents randomly
			myPC <- one_of(driving_pc_polygons);
			location <- any_location_in(myPC);
			my_home_location <- location;
		}

		//ASSIGN SITUATIONAL ATTRIBUTES TO AGENTS ONCE THEY HAVE A LOCATION
		albatross_Xdag <- world.classify_xdag(myPC.xdag);
		albatross_Xndag <- world.classify_xndag(myPC.xndag);
		albatross_Xarb <- world.classify_xarb(myPC.xarb);
		albatross_Xpop <- world.classify_xpop(myPC.xpop);
		albatross_Ddag <- world.classify_ddag(myPC.ddag);
		albatross_Dndag <- world.classify_dndag(myPC.dndag);
		albatross_Darb <- world.classify_darb(myPC.darb);
		albatross_Dpop <- world.classify_dpop(myPC.dpop);
		//save [albatross_Darb] to:"../R/useTrees/1.csv" type:csv header:true;

		//write build_d1_parameters(self);
		
		
		////// INITIALIZE AND FIX A WHOLE DAY ACTIVITY
		
		_I_am_working_today <- do_i_go_work_today();
		_I_have_a_nonWork_trip <- do_i_go_out_for_leisure(_I_am_working_today);
		if _I_am_working_today
		{
			_Is_it_full_time <- do_i_work_full_time();
			_do_I_work_within_my_municipality <- world.work_in_municipality();

			
			_my_distance_to_work_today <- world.work_distance(_do_I_work_within_my_municipality)*1000+100; //to change from km to meters and added 100m to avoid 0 error for people staying at home
			//write name+ "    " +_my_distance_to_work_today;
			_my_workplace<- (driving_pc_polygons at_distance _my_distance_to_work_today) farthest_to self;
			if(_my_workplace = nil){
				_my_workplace <- myPC;
			}
			
			
			
			
			_leave_home_for_office_in_cycle <- world.startTime_in_cycles();
			add _leave_home_for_office_in_cycle to:_current_activity_endtime;
			add any_location_in(_my_workplace) to:_consequent_next_activity_location;
			
			_time_taken_to_home_from_work_in_cycles <-  max([int((_my_distance_to_work_today/speed_mps)/900),1]);
			
			if _Is_it_full_time
			{
				my_link <- link((self), (_my_workplace));
				
				_leave_work_at_cycle <- _leave_home_for_office_in_cycle + world.leave_office((_Is_it_full_time));
				add _leave_work_at_cycle to:_current_activity_endtime;
				
				time_left_afterWork_incycles <- 96 - _leave_work_at_cycle;
				
				
				if _I_have_a_nonWork_trip
				{
//					if _time_taken_to_home_from_work_in_cycles * risk_factor < time_left_afterWork_incycles -6 //6 is 90 minutes of non-work activity
//					{
						
						_leisure_distance <- world.leisure_distance(); // from albatross patterns
						_leisure_location <- one_of(first(5,driving_pc_polygons sort_by (each.horeca) at_distance _leisure_distance)); //select one of the top five recreational areas
						
						
						if _leisure_location = nil{
							add my_home_location to:_consequent_next_activity_location;
						} else {
							
							add any_location_in(_leisure_location) to:_consequent_next_activity_location;
							
							_time_to_leisure_location_in_cycles <-  max([int((_leisure_distance/speed_mps)/900),1]);
							_leave_leisure_at_cycle <- _leave_work_at_cycle + _time_to_leisure_location_in_cycles + any([4,6,8]); // 4, 6 8 are number of steps, each step is 15 minutes
							
							add _leave_leisure_at_cycle to:_current_activity_endtime;
							add my_home_location to:_consequent_next_activity_location;
							
						}
						
						
//					}
//					 else
//					{
//						add my_home_location to:next_activity_location;
//					}

				} else //if (cycle mod 96 > _leave_work_at_cycle)
				{
					write "leaving office";
					add my_home_location to:_consequent_next_activity_location;
				}
				
			} else //if not(_Is_it_full_time)
			{
				_leave_work_at_cycle <- _leave_home_for_office_in_cycle + world.leave_office(_Is_it_full_time);
				add _leave_work_at_cycle to:_current_activity_endtime;
				my_link <- link((self), (_my_workplace));
				time_left_afterWork_incycles <- 96 - _leave_work_at_cycle;
				//---
				if _I_have_a_nonWork_trip
				{
//					if _time_taken_to_home_from_work_in_cycles * risk_factor < time_left_afterWork_incycles -6 //6 is 90 minutes of non-work activity
//					{
						
						_leisure_distance <- world.leisure_distance(); // from albatross patterns
						_leisure_location <- one_of(first(5,driving_pc_polygons sort_by (each.horeca) at_distance _leisure_distance)); //select one of the top five recreational areas
						
						
						if _leisure_location = nil{
							add my_home_location to:_consequent_next_activity_location;
						} else {
							
							add any_location_in(_leisure_location) to:_consequent_next_activity_location;
							
							_time_to_leisure_location_in_cycles <-  max([int((_leisure_distance/speed_mps)/900),1]);
							_leave_leisure_at_cycle <- _leave_work_at_cycle + _time_to_leisure_location_in_cycles + any([4,6,8]); // 4, 6 8 are number of steps, each step is 15 minutes
							add _leave_leisure_at_cycle to:_current_activity_endtime;
							add my_home_location to:_consequent_next_activity_location;
							
							
						}
						
						
//					}
//					 else
//					{
//						add my_home_location to:next_activity_location;
//					}

				} else// if (cycle mod 90 > _leave_work_at_cycle)
				{
					add my_home_location to:_consequent_next_activity_location;
				}
				
				//---
				
				
			}

		} else //if not (_I_am_working_today)
		{
			_leave_home_for_office_in_cycle <- world.startTime_in_cycles(); //office is here leisure activity
			
			add _leave_home_for_office_in_cycle to: _current_activity_endtime; //leave home for leisure
			
			_leisure_distance <- world.leisure_distance(); // from albatross patterns
			_leisure_location <- one_of(first(5, driving_pc_polygons sort_by (each.horeca) at_distance _leisure_distance)); //select one of the top five recreational areas
			
			if _leisure_location = nil
			{
				add my_home_location to: _consequent_next_activity_location;
			} else
			{
				add any_location_in(_leisure_location) to: _consequent_next_activity_location;
				_time_to_leisure_location_in_cycles <- max([int((_leisure_distance / speed_mps) / 900), 1]);
				
				_leave_leisure_at_cycle <- _leave_home_for_office_in_cycle + _time_to_leisure_location_in_cycles + any([4, 6, 8]); // 4, 6 8 are number of steps, each step is 15 minutes
				add _leave_leisure_at_cycle to: _current_activity_endtime;
				add my_home_location to: _consequent_next_activity_location;
				
			}

			}
		//save [name,my_link.perimeter] to: "srirama.csv" type:csv rewrite:false;

	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///																					     ///
	///							DAY ROUTINES									 			     ///
	///																					     ///
	///    																			             ///
	///																					     ///
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	reflex fix_daily_routine when: cycle mod 96 = 0 and cycle >1
	{
		
		_consequent_next_activity_location<-[];
		_current_activity_endtime<-[];
		_I_am_working_today <- do_i_go_work_today();
		_I_have_a_nonWork_trip <- do_i_go_out_for_leisure(_I_am_working_today);
		if _I_am_working_today
		{
			_Is_it_full_time <- do_i_work_full_time();
			_do_I_work_within_my_municipality <- world.work_in_municipality();

			
			//_my_distance_to_work_today <- flip(0.95) ? self._my_distance_to_work_today : world.work_distance(_do_I_work_within_my_municipality);
			_my_distance_to_work_today <- world.work_distance(_do_I_work_within_my_municipality)*1000+100;
			write name +"  "+_my_distance_to_work_today;
			_my_workplace<- (driving_pc_polygons at_distance _my_distance_to_work_today) farthest_to self;
			if(_my_workplace = nil){
				_my_workplace <- myPC;
			}
			
			_time_taken_to_home_from_work_in_cycles <-  max([int((_my_distance_to_work_today/speed_mps)/900),1]);
			
			
			_leave_home_for_office_in_cycle <- world.startTime_in_cycles();
			add _leave_home_for_office_in_cycle to:_current_activity_endtime;
			add any_location_in(_my_workplace) to:_consequent_next_activity_location;
			
			if _Is_it_full_time
			{
				my_link <- link((self), _my_workplace);
				
				_leave_work_at_cycle <- _leave_home_for_office_in_cycle + world.leave_office((_Is_it_full_time));
				time_left_afterWork_incycles <- 96 - _leave_work_at_cycle;
				add _leave_work_at_cycle to:_current_activity_endtime;
				
				
				
				if _I_have_a_nonWork_trip
				{
					if _time_taken_to_home_from_work_in_cycles * risk_factor < time_left_afterWork_incycles -6 //6 is 90 minutes of non-work activity
					{
						
						_leisure_distance <- world.leisure_distance(); // from albatross patterns
						_leisure_location <- one_of(first(5,driving_pc_polygons sort_by (each.horeca) at_distance _leisure_distance)); //select one of the top five recreational areas
						
						
						if _leisure_location = nil{
							add my_home_location to:_consequent_next_activity_location;
						} else {
							add any_location_in(_leisure_location) to:_consequent_next_activity_location;
							_time_to_leisure_location_in_cycles <-  max([int((_leisure_distance/speed_mps)/900),1]);
							_leave_leisure_at_cycle <- _leave_work_at_cycle + _time_to_leisure_location_in_cycles + any([4,6,8]); // 4, 6 8 are number of steps, each step is 15 minutes
							add _leave_leisure_at_cycle to:_current_activity_endtime;
							add my_home_location to:_consequent_next_activity_location;
							
						}
						
						
					} else
					{
						add my_home_location to:_consequent_next_activity_location;
					}

				} else if (cycle mod 90 > _leave_work_at_cycle)
				{
					add my_home_location to:_consequent_next_activity_location;
				}
				
			} else if not(_Is_it_full_time)
			{
				_leave_work_at_cycle <- _leave_home_for_office_in_cycle + world.leave_office(_Is_it_full_time);
				add _leave_work_at_cycle to:_current_activity_endtime;
				my_link <- link((self), (_my_workplace));
				time_left_afterWork_incycles <- 96 - _leave_work_at_cycle;
				//---
				if _I_have_a_nonWork_trip
				{
					if _time_taken_to_home_from_work_in_cycles * risk_factor < time_left_afterWork_incycles -6 //6 is 90 minutes of non-work activity
					{
						
						_leisure_distance <- world.leisure_distance(); // from albatross patterns
						_leisure_location <- one_of(first(5,driving_pc_polygons sort_by (each.horeca) at_distance _leisure_distance)); //select one of the top five recreational areas
						
						
						if _leisure_location = nil{
							add my_home_location to:_consequent_next_activity_location;
						} else {
							add any_location_in(_leisure_location) to:_consequent_next_activity_location;
							
							_time_to_leisure_location_in_cycles <-  max([int((_leisure_distance/speed_mps)/900),1]);
							_leave_leisure_at_cycle <- _leave_work_at_cycle + _time_to_leisure_location_in_cycles + any([4,6,8]); // 4, 6 8 are number of steps, each step is 15 minutes
							add _leave_leisure_at_cycle to:_current_activity_endtime;
							add my_home_location to:_consequent_next_activity_location;
							
							
						}
						
						
					} else
					{
						add my_home_location to:_consequent_next_activity_location;
					}

				} else if (cycle mod 90 > _leave_work_at_cycle)
				{
					add my_home_location to:_consequent_next_activity_location;
				}
				
				//---
				
				
			}

		} else if not (_I_am_working_today)
		{
			_leave_home_for_office_in_cycle <- world.startTime_in_cycles(); //office is here leisure activity
			
			add _leave_home_for_office_in_cycle to: _current_activity_endtime; //leave home for leisure
			
			_leisure_distance <- world.leisure_distance(); // from albatross patterns
			_leisure_location <- one_of(first(5, driving_pc_polygons sort_by (each.horeca) at_distance _leisure_distance)); //select one of the top five recreational areas
			
			if _leisure_location = nil
			{
				add my_home_location to: _consequent_next_activity_location;
			} else
			{
				add any_location_in(_leisure_location) to: _consequent_next_activity_location;
				_time_to_leisure_location_in_cycles <- max([int((_leisure_distance / speed_mps) / 900), 1]);
				_leave_leisure_at_cycle <- _leave_work_at_cycle + _time_to_leisure_location_in_cycles + any([4, 6, 8]); // 4, 6 8 are number of steps, each step is 15 minutes
				add _leave_leisure_at_cycle to: _current_activity_endtime;
				add my_home_location to: _consequent_next_activity_location;
				
			}

			}

	}
	
	action go_home{
		do goto target:my_home_location on:the_graph;
	}

	bool do_i_go_work_today
	{
		return day_of_week > 5 ? flip(0.05) : flip(0.95);
	}

	bool do_i_work_full_time
	{
		return flip(0.8); //80 percent work full time
	}

	bool do_i_go_out_for_leisure (bool _work)
	{
		return _work ? flip(0.2) : flip(0.8);
	}

	action get_distance_to_home
	{
		using topology(the_graph)
		{
			//write "distanceToHome" + self distance_to driving_people[0].location;
		}

		//write "distance Euclidian ToHome" + self distance_to driving_people[0].location;
	}

	aspect a
	{
		draw circle(300) color: # green;
		draw circle(3100) color: rgb(# red, 0.2);
		draw my_link color:#blue;
	}
	
	

}

experiment ABCDdrivingSimple type: gui
{
/** Insert here the definition of the input and output of the model */
	output
	{
		display first type: java2D focus: is_number(put_in_postcode) and (put_in_postcode) != 0 ? (first(driving_pc_polygons where (each.pc = put_in_postcode))) : world.shape
		{
			species driving_pc_polygons aspect: a;
			species driving_people aspect: a;
			species driving_roads aspect: a;
			species driving_pointShape aspect: a;
		}
		
		display chart_display{
			chart "trip length" type:histogram{
				data "]0;0.5]" value: driving_people count (each._my_distance_to_work_today <= 0.5*1000) color: #red ;
				data "]0.5;2.5]" value: driving_people count ((each._my_distance_to_work_today > 0.5*1000) and (each._my_distance_to_work_today <= 2.5*1000)) color: #red ;
				data "]2.5;3.5]" value: driving_people count ((each._my_distance_to_work_today > 2.5*1000) and (each._my_distance_to_work_today <= 3.5*1000)) color: #red ;
				data "]3.5;5.5]" value: driving_people count ((each._my_distance_to_work_today > 3.5*1000) and (each._my_distance_to_work_today <= 5.5*1000)) color: #red ;
				data "]5.5;9.5]" value: driving_people count ((each._my_distance_to_work_today > 5.5*1000) and (each._my_distance_to_work_today <= 9.5*1000)) color: #red ;
				data "]9.5;17.5]" value: driving_people count ((each._my_distance_to_work_today > 9.5*1000) and (each._my_distance_to_work_today <= 17.5*1000)) color: #red ;
				
				data "]17.5;200]" value: driving_people count (each._my_distance_to_work_today > 17.5*1000) color: #red;
			}
		}

	}

}
