# This program calculates the end-to-end delay for individual packets in traffic flow 0

# Usage: awk -f 5example2pktdelay_flow0.awk example2.tr

BEGIN {

highest_packet_id = 0;

}

{

action = $1;

time = $2;

from = $3;

to = $4;

type = $5;

pktsize = $6;

flow_id = $8;

src = $9;

dst = $10;

seq_no = $11;

packet_id = $12;


if ( flow_id == 0) {


   if ( packet_id > highest_packet_id )

      highest_packet_id = packet_id;


   if ( start_time[packet_id] == 0 )

      start_time[packet_id] = time;


   if ( action == "d" ) 

      end_time[packet_id] = -1;

   else 

      if ( action == "r" && to == 2 ) 

         end_time[packet_id] = time;

}


}



END {

for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) {

   start = start_time[packet_id];

   end = end_time[packet_id];

   packet_duration = end - start;


   if ( start < end ) printf("%f \t %f\n", start, packet_duration) > "example2pktdelay_flow0.xls";

}

}
