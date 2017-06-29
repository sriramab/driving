/**
* Name: classify
* Author: skbhamidipati
* Description: 
* Tags: Tag1, Tag2, TagN
*/
model classify

/* Insert your model definition here */
global
{
	int classify_xdag (int i)
	{
		int r;
		switch i
		{
			match_between [0, 114]
			{
				r <- 0;
				return r;
			}

			match_between [115, 252]
			{
				r <- 1;
				return r;
			}

			match_between [253, 306]
			{
				r <- 2;
				return r;
			}

			match_between [307, 506]
			{
				r <- 3;
				return r;
			}

			match_between [507, 675]
			{
				r <- 4;
				return r;
			}

			match_between [676, 100000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_xndag (int i)
	{
		int r;
		switch i
		{
			match_between [0, 395]
			{
				r <- 0;
				return r;
			}

			match_between [396, 635]
			{
				r <- 1;
				return r;
			}

			match_between [636, 762]
			{
				r <- 2;
				return r;
			}

			match_between [763, 938]
			{
				r <- 3;
				return r;
			}

			match_between [939, 2525]
			{
				r <- 4;
				return r;
			}

			match_between [2525, 100000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_xarb (int i)
	{
		int r;
		switch i
		{
			match_between [0, 8785]
			{
				r <- 0;
				return r;
			}

			match_between [8786, 12995]
			{
				r <- 1;
				return r;
			}

			match_between [12996, 16120]
			{
				r <- 2;
				return r;
			}

			match_between [16121, 20199]
			{
				r <- 3;
				return r;
			}

			match_between [20200, 70314]
			{
				r <- 4;
				return r;
			}

			match_between [70315, 1000000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_xpop (int i)
	{
		int r;
		switch i
		{
			match_between [0, 5050]
			{
				r <- 0;
				return r;
			}

			match_between [5051, 8845]
			{
				r <- 1;
				return r;
			}

			match_between [8846, 13217]
			{
				r <- 2;
				return r;
			}

			match_between [13218, 16833]
			{
				r <- 3;
				return r;
			}

			match_between [16834, 22884]
			{
				r <- 4;
				return r;
			}

			match_between [22885, 1000000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_ddag (float i)
	{
		int r;
		switch i
		{
			match_between [0, 71.9]
			{
				r <- 0;
				return r;
			}

			match_between [72, 127.9]
			{
				r <- 1;
				return r;
			}

			match_between [128, 165.9]
			{
				r <- 2;
				return r;
			}

			match_between [166, 202.9]
			{
				r <- 3;
				return r;
			}

			match_between [203, 346.9]
			{
				r <- 4;
				return r;
			}

			match_between [347, 10000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_dndag (float i)
	{
		int r;
		switch i
		{
			match_between [0, 92.9]
			{
				r <- 0;
				return r;
			}

			match_between [93, 145.9]
			{
				r <- 1;
				return r;
			}

			match_between [146, 176.9]
			{
				r <- 2;
				return r;
			}

			match_between [177, 258.9]
			{
				r <- 3;
				return r;
			}

			match_between [259, 334.9]
			{
				r <- 4;
				return r;
			}

			match_between [335, 10000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_darb (float i)
	{
		int r;
		switch i
		{
			match_between [0, 91.9]
			{
				r <- 0;
				return r;
			}

			match_between [92, 127.9]
			{
				r <- 1;
				return r;
			}

			match_between [128, 200.9]
			{
				r <- 2;
				return r;
			}

			match_between [201, 273.9]
			{
				r <- 3;
				return r;
			}

			match_between [274, 359.9]
			{
				r <- 4;
				return r;
			}

			match_between [360, 10000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_dpop (float i)
	{
		int r;
		switch i
		{
			match_between [0, 0.9]
			{
				r <- 0;
				return r;
			}

			match_between [1, 104.9]
			{
				r <- 1;
				return r;
			}

			match_between [105, 125.9]
			{
				r <- 2;
				return r;
			}

			match_between [126, 162.9]
			{
				r <- 3;
				return r;
			}

			match_between [163, 277.9]
			{
				r <- 4;
				return r;
			}

			match_between [278, 10000]
			{
				r <- 5;
				return r;
			}

		}

	}

	int classify_dur (float i)
	{
		int r;
		switch i
		{
			match_between [0, 384.9]
			{
				r <- 0;
				return r;
			}

			match_between [385, 489.9]
			{
				r <- 1;
				return r;
			}

			match_between [490, 524.9]
			{
				r <- 2;
				return r;
			}

			match_between [525, 559.9]
			{
				r <- 3;
				return r;
			}

			match_between [560, 10000]
			{
				r <- 4;
				return r;
			}

		}

	}

	float get_distance (int avg <- 10, string purpose <- "work")
	{
		int n <- 1;
		float d;
		switch purpose
		{
			match "work"
			{
				d <- float(gamma_rnd(2, avg));
			}

			match "weekend"
			{
				if (flip(0.9))
				{
					d <- float(gamma_rnd(1, avg));
				}

			}

		}

		return d;
	}
	
	//-----------------------------
	float leisure_distance 
	{

	//RETURNS DISTANCE TO LEISURE PLACE WITH SAME PROBABILITY AS OBSERVED IN ALBATROSS-MON  ALL ACTIVITIES TABLE
		list<float> probabilities_List;
		list<int> albatross_leisure_trend <- [297, 107, 141, 203, 73, 78, 29]; //page253, table 13
		
		
			probabilities_List <-
			[albatross_leisure_trend[0] / sum(albatross_leisure_trend), albatross_leisure_trend[1] / sum(albatross_leisure_trend), 
				albatross_leisure_trend[2] / sum(albatross_leisure_trend), albatross_leisure_trend[3] / sum(albatross_leisure_trend), 
				albatross_leisure_trend[4] / sum(albatross_leisure_trend), albatross_leisure_trend[5] / sum(albatross_leisure_trend), 
				albatross_leisure_trend[6]/sum(albatross_leisure_trend)
			];
		

		return float(first(sample([rnd(0.5), rnd(0.5, 2.5), rnd(2.5, 3.5), rnd(3.5, 5.5), rnd(5.5, 9.5), rnd(9.5, 17.5), rnd(17.5, 100)], 1, false, probabilities_List)));
	}
	
	
	//------------------------------

	float work_distance (bool working_within_municipality)
	{

	//RETURNS DISTANCE TO WORK PLACE WITH SAME PROBABILITY AS OBSERVED IN ALBATROSS-MON
		list<float> probabilities_List;
		list<int> albatross_work_trend <- [83, 31, 107, 133, 99, 141, 138]; //page253, table 13
		if working_within_municipality
		{
			probabilities_List <-
			[albatross_work_trend[0] / sum(albatross_work_trend), albatross_work_trend[1] / sum(albatross_work_trend), albatross_work_trend[2] / sum(albatross_work_trend), albatross_work_trend[3] / sum(albatross_work_trend), albatross_work_trend[4] / sum(albatross_work_trend), albatross_work_trend[5] / sum(albatross_work_trend), 0.0];
		} else
		{
			probabilities_List <- [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0];
		}

		return float(first(sample([rnd(0.5), rnd(0.5, 2.5), rnd(2.5, 3.5), rnd(3.5, 5.5), rnd(5.5, 9.5), rnd(9.5, 17.5), rnd(17.5, 100)], 1, false, probabilities_List)));
	}

	bool work_in_municipality
	{
	//RETURNS TRUE OF FALSE BASED ON TRENDS IN ALBATROSS
		return flip(0.75); // page 252, table11
	}

	// BASED ON fitdist(aidwork6$startTime, dnorm) ; WE GET MEAN 490.05 AND SD 55.6, BASED ON MON ALBATROSS MEASUREMENTS
	int startTime_in_cycles
	{
		float startTime <- (gauss(490, 56) / 60); //results in hours dot 100th of an hour = meaning 0.25 is 15 minutes
		int startTime_hours_to_cycles <- int(startTime) * 4; // one hour has 4 steps in gama model definition, see main file for step
		float in_cycles_minutes <- startTime - int(startTime);
		int add_cycles;
		switch in_cycles_minutes
		{
			match_between [0, 0.25]
			{
				add_cycles <- 1;
			}

			match_between [0.26, 0.50]
			{
				add_cycles <- 2;
			}

			match_between [0.56, 0.75]
			{
				add_cycles <- 3;
			}

			match_between [0.75, 1.0]
			{
				add_cycles <- 4;
			}

		}

		int leave_home_at_cycle <- startTime_hours_to_cycles + add_cycles;
		return leave_home_at_cycle;
	}

	// BASED ON FULL TIME OR PART TIME, THIS GIVES THE DURATION FROM aidwork2$duration filtered to full or part tie
	// FOR FULL TIME WE GET A NORMAL DISTRIBUTION WITH mean = 493 and sd = 117min
	// FOR PART TIME WE GET A NORMAL DISTRIBUTION WITH mean = 399min and sd = 135min
	int leave_office(bool full_or_part)
	{
		float dur; //duration as per albatross distribution
		int dur_hours_to_cycles;
		float dur_minutes;
		int dur_minutes_to_cycles;
		int add_cycles;
		switch full_or_part
		{
			match true //means agent is working full time
			{
				dur <- gauss(493, 117) / 60; //results in hours dot 100th of an hour = meaning 0.25 is 15 minutes
				dur_hours_to_cycles <- int(dur) * 4; // one hour has 4 steps in gama model definition, see main file for step
				dur_minutes <- dur - int(dur);
				switch dur_minutes
				{
					match_between [0, 0.25]
					{
						add_cycles <- 1;
					}

					match_between [0.26, 0.50]
					{
						add_cycles <- 2;
					}

					match_between [0.56, 0.75]
					{
						add_cycles <- 3;
					}

					match_between [0.75, 1.0]
					{
						add_cycles <- 4;
					}

				}
				int leave_work_after_cycles <- dur_hours_to_cycles + add_cycles;
				return leave_work_after_cycles;

			}

			match false //means agent is working part time
			{
				dur <- gauss(399, 135) / 60; //results in hours dot 100th of an hour = meaning 0.25 is 15 minutes
				dur_hours_to_cycles <- int(dur) * 4; // one hour has 4 steps in gama model definition, see main file for step
				dur_minutes <- dur - int(dur);
				switch dur_minutes
				{
					match_between [0, 0.25]
					{
						add_cycles <- 1;
					}

					match_between [0.26, 0.50]
					{
						add_cycles <- 2;
					}

					match_between [0.56, 0.75]
					{
						add_cycles <- 3;
					}

					match_between [0.75, 1.0]
					{
						add_cycles <- 4;
					}

				}
				int leave_work_after_cycles <- dur_hours_to_cycles + add_cycles;
				return leave_work_after_cycles;

			}

		}

		
	}

	init
	{
		int k <- classify_xdag(133);
		//write k;
		float dd <- get_distance(10, "weekend");
		//write dd;
		float kk <- get_distance(avg: 10, purpose: "weekend");
		//write kk;
		float distance_work <- get_distance(avg: 20, purpose: "weekend");
		//write "aukes distance to work  " + distance_work;
	}

}

experiment name type: gui
{

// Define parameters here if necessary
// parameter "My parameter" category: "My parameters" var: one_global_attribute;

// Define attributes, actions, a init section and behaviors if necessary
// init { }
	output
	{
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