/**
* Name: new
* Author: skbhamidipati
* Description: Describe here the model and its experiments
* Tags: Tag1, Tag2, TagN
*/

model new

global {
	init{
		create a number:1;
		create b number:1;
		write int(true);
		write int(false);
		list<float> one<-[1.0,2.0,3.0];
		list<float> two <- [0.1, 0.2, 0.3];
		list<float> three <- matrix(one)+matrix(two);
		write three; 
	}
	/** Insert the global definitions, variables and actions here */
	
}

species a{
	int aa<-10;
	reflex abc{
		//write aa;
	}
}

species b{
	int aa;
	init{
		ask a{
			self.aa<-myself.aa;
		}
	}
}

experiment new type: gui {
	/** Insert here the definition of the input and output of the model */
	output {
	}
}
