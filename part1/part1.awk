# This awk file calculates throughput, number of packets sent, received, and lost for every 0.5 time interval for each of the three flows, and export the results to a merged excel file for all flows


BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
   num_packets_flow0 = 0;
   num_packets_flow1 = 0;
   num_packets_flow2 = 0;
   num_packets_flow3 = 0;
   lost_packets_flow0 = 0;
   lost_packets_flow1 = 0;
   lost_packets_flow2 = 0;
   lost_packets_flow3 = 0;
   sent_packets_flow0 = 0;
   sent_packets_flow1 = 0;
   sent_packets_flow2 = 0;
   sent_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {

      # Export cumulative number of received packets to xls file
      printf("%f \t %f \t %f \t %f \t %f\n", time2, num_packets_flow0, num_packets_flow1, num_packets_flow2,num_packets_flow3) > "example2_receivedpkts.xls";
      num_packets_flow0 = 0;
      num_packets_flow1 = 0;
      num_packets_flow2 = 0;
      num_packets_flow3 = 0;
      # Export cumulative number of lost packets to xls file
      printf("%f \t %f \t %f \t %f \t %f\n", time2, lost_packets_flow0, lost_packets_flow1, lost_packets_flow2, lost_packets_flow3) > "example2_lostpkts.xls";
      lost_packets_flow0 = 0;
      lost_packets_flow1 = 0;
      lost_packets_flow2 = 0;
      lost_packets_flow3 = 0;

      # Export cumulative number of sent packets to xls file
      printf("%f \t %f \t %f \t %f \t %f\n", time2, sent_packets_flow0, sent_packets_flow1, sent_packets_flow2, sent_packets_flow3) > "example2_sentpkts.xls";
      sent_packets_flow0 = 0;
      sent_packets_flow1 = 0;
      sent_packets_flow2 = 0;
      sent_packets_flow3 = 0;


      time1 = $2;

   }



   # if packet arrives at destination node n2 belongs to flow id 11
   if ($1 == "r" && $4 == 11 && $8 == 11) {
      num_packets_flow0++;
   }

   # if packet arrives at destination node n3 belongs to flow id 12
   if ($1 == "r" && $4 == 12 && $8 == 12) {
      num_packets_flow1++;
   }

   # if packet arrives at destination node n4 belongs to flow id 16
   if ($1 == "r" && $4 == 16 && $8 == 16) {
      num_packets_flow2++;
   }

    # if packet arrives at destination node n4 belongs to flow id 17
   if ($1 == "r" && $4 == 17 && $8 == 17) {
      num_packets_flow3++;
   }



   # if a packet belongs to flow id 0 was dropped at any node along the path
   if ($1 == "d" && $8 == 11) {
      lost_packets_flow0++;
   }

   # if a packet belongs to flow id 1 was dropped at any node along the path
   if ($1 == "d" && $8 == 12) {
      lost_packets_flow1++;
   }

   # if a packet belongs to flow id 2 was dropped at any node along the path
   if ($1 == "d" && $8 == 16) {
      lost_packets_flow2++;
   }

   # if a packet belongs to flow id 2 was dropped at any node along the path
   if ($1 == "d" && $8 == 17) {
      lost_packets_flow3++;
   }


   # if a packet belongs to flow id 0 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 8 && $8 == 11) {
      sent_packets_flow0++;
   }

   # if a packet belongs to flow id 1 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 9 && $8 == 12) {
      sent_packets_flow1++;
   }

   # if a packet belongs to flow id 2 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 8 && $8 == 16) {
      sent_packets_flow2++;
   }

    # if a packet belongs to flow id 2 was sent from source node n0 (entered to the proper outgoing link queue)
   if ($1 == "+"  && $3 == 9 && $8 == 17) {
      sent_packets_flow3++;
   }


}

END {
   print("****End of awk file****");
}

