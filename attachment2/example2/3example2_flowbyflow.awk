# This awk file calculates throughput, number of packets sent, received, and lost for every 0.5 time interval for each of the three flows, and export the results to separate excel files for each flow

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
   num_packets_flow0 = 0;
   num_packets_flow1 = 0;
   num_packets_flow2 = 0;
   lost_packets_flow0 = 0;
   lost_packets_flow1 = 0;
   lost_packets_flow2 = 0;
   sent_packets_flow0 = 0;
   sent_packets_flow1 = 0;
   sent_packets_flow2 = 0;
}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {

      throughput_flow0 = bytes_counter_flow0 / timeInterval;
      # Export throughput of this time interval to xls file 
      printf("%f \t %f\n", time2, throughput_flow0) > "example2_throughput_flow0.xls";
      bytes_counter_flow0 = 0;
      # Export number of received packets to xls file
      printf("%f \t %f\n", time2, num_packets_flow0) > "example2_receivedpkts_flow0.xls";
      num_packets_flow0 = 0;
      # Export number of lost packets to xls file
      printf("%f \t %f\n", time2, lost_packets_flow0) > "example2_lostpkts_flow0.xls";
      lost_packets_flow0 = 0;
      # Export number of sent packets to xls file
      printf("%f \t %f\n", time2, sent_packets_flow0) > "example2_sentpkts_flow0.xls";
      sent_packets_flow0 = 0;

      throughput_flow1 = bytes_counter_flow1 / timeInterval;
      # Export throughput of this time interval to xls file 
      printf("%f \t %f\n", time2, throughput_flow1) > "example2_throughput_flow1.xls";
      bytes_counter_flow1 = 0;
      # Export number of received packets to xls file
      printf("%f \t %f\n", time2, num_packets_flow1) > "example2_receivedpkts_flow1.xls";
      num_packets_flow1 = 0;
      # Export number of lost packets to xls file
      printf("%f \t %f\n", time2, lost_packets_flow1) > "example2_lostpkts_flow1.xls";
      lost_packets_flow1 = 0;
      # Export number of sent packets to xls file
      printf("%f \t %f\n", time2, sent_packets_flow1) > "example2_sentpkts_flow1.xls";
      sent_packets_flow1 = 0;

      throughput_flow2 = bytes_counter_flow2 / timeInterval;
      # Export throughput of this time interval to xls file 
      printf("%f \t %f\n", time2, throughput_flow2) > "example2_throughput_flow2.xls";
      bytes_counter_flow2 = 0;
      # Export number of received packets to xls file
      printf("%f \t %f\n", time2, num_packets_flow2) > "example2_receivedpkts_flow2.xls";
      num_packets_flow2 = 0;
      # Export number of lost packets to xls file
      printf("%f \t %f\n", time2, lost_packets_flow2) > "example2_lostpkts_flow2.xls";
      lost_packets_flow2 = 0;
      # Export number of sent packets to xls file
      printf("%f \t %f\n", time2, sent_packets_flow2) > "example2_sentpkts_flow2.xls";
      sent_packets_flow2 = 0;

      time1 = $2;

   }



   # if packet arrives at destination node n2 belongs to flow id 0
   if ($1 == "r" && $4 == 2 && $8 == 0) {
      bytes_counter_flow0 += $6;
      num_packets_flow0++;
   }

   # if packet arrives at destination node n3 belongs to flow id 1
   if ($1 == "r" && $4 == 3 && $8 == 1) {
      bytes_counter_flow1 += $6;
      num_packets_flow1++;
   }

   # if packet arrives at destination node n4 belongs to flow id 2
   if ($1 == "r" && $4 == 4 && $8 == 2) {
      bytes_counter_flow2 += $6;
      num_packets_flow2++;
   }



   # if a packet belongs to flow id 0 was dropped at any node along the path
   if ($1 == "d" && $8 == 0) {
      lost_packets_flow0++;
   }

   # if a packet belongs to flow id 1 was dropped at any node along the path
   if ($1 == "d" && $8 == 1) {
      lost_packets_flow1++;
   }

   # if a packet belongs to flow id 2 was dropped at any node along the path
   if ($1 == "d" && $8 == 2) {
      lost_packets_flow2++;
   }


   # if a packet belongs to flow id 0 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 0 && $8 == 0) {
      sent_packets_flow0++;
   }

   # if a packet belongs to flow id 1 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 0 && $8 == 1) {
      sent_packets_flow1++;
   }

   # if a packet belongs to flow id 2 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 0 && $8 == 2) {
      sent_packets_flow2++;
   }



}

END {
   print("****End of awk file****");
}

