# This awk file calculates throughput, number of packets sent, received, and lost for every 0.5 time interval for each of the three flows, and export the results to a merged excel file for all flows


BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   
highest_packet_id = 0;
delay[11] = 0;
delay[12] = 0;
delay[16] = 0;
delay[17] = 0;

count[11] = 0;
count[12] = 0;
count[16] = 0;
count[17] = 0;

   timeInterval = 0.0;

}


function delayCalc() {
	
}

{
   action = $1;

time2 = $2;

from = $3;

to = $4;

type = $5;

pktsize = $6;

flow_id = $8;

src = $9;

dst = $10;

seq_no = $11;

packet_id = $12;

   timeInterval = time2 - time1;

    if (action == "+" ){

		
        if ( packet_id > highest_packet_id )

        highest_packet_id = packet_id;


        if ( start_time[packet_id] == 0 ){

            start_time[packet_id] = time2;
        }

	} else if ( action == "d" ) {
		end_time[packet_id] = -1; #-1 is used to show the packet is dropped

	} else if ( action == "r" && to == 2 ) {
					
		end_time[packet_id] = time2;
					
		delay[flow_id] = (delay[flow_id]*coun[flow_id]t+ (time2 - start_time[packet_id]))/(count[flow_id]+1);
		count[flow_id]++;
	}


   if ( timeInterval > 0.5) {

        printf("%f \t %f \t %f \t %f \t %f\n", time2, delay[11], delay[12], delay[16], delay[17]) > "example2avgdelay.xls";



      time1 = $2;

   }


}

END {
   print("****End of awk file****");
}

