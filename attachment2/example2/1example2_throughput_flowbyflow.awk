# This awk file calculates throughput, number of packets sent, received, and lost for every 0.5 time interval for each of the three flows

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {

      throughput_flow0 = bytes_counter_flow0 / timeInterval;
      # Export throughput of this time interval to xls file 
      printf("%f \t %f\n", time2, throughput_flow0) > "example2_throughput_flow0.xls";
      bytes_counter_flow0 = 0;

      throughput_flow1 = bytes_counter_flow1 / timeInterval;
      # Export throughput of this time interval to xls file 
      printf("%f \t %f\n", time2, throughput_flow1) > "example2_throughput_flow1.xls";
      bytes_counter_flow1 = 0;

      throughput_flow2 = bytes_counter_flow2 / timeInterval;
      # Export throughput of this time interval to xls file 
      printf("%f \t %f\n", time2, throughput_flow2) > "example2_throughput_flow2.xls";
      bytes_counter_flow2 = 0;

      time1 = $2;

   }



   # if packet arrives at destination node n2 belongs to flow id 0
   if ($1 == "r" && $4 == 2 && $8 == 0) {
      bytes_counter_flow0 += $6;
   }

   # if packet arrives at destination node n3 belongs to flow id 1
   if ($1 == "r" && $4 == 3 && $8 == 1) {
      bytes_counter_flow1 += $6;
   }

   # if packet arrives at destination node n4 belongs to flow id 2
   if ($1 == "r" && $4 == 4 && $8 == 2) {
      bytes_counter_flow2 += $6;
   }


}

END {
   print("****End of awk file****");
}

