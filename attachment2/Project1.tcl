#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open tracefile.tr w]
$ns trace-all $tracefd


#Define a 'finish' procedure
proc finish {} {
        global ns nf
        $ns flush-trace
        exit 0
}

#Create Nodes
        #****** Router Nodes ******#
        set n0 [$ns node]
        set n1 [$ns node]
        set n2 [$ns node]
        set n3 [$ns node]
        set n4 [$ns node]
        set n5 [$ns node]
        set n6 [$ns node]
        set n7 [$ns node]

        #****** SRC NODES ******#
        set n8 [$ns node]
        set n9 [$ns node]

        #****** DST LINKS ******#
        set n10 [$ns node]
        set n11 [$ns node]
        set n12 [$ns node]
        set n13 [$ns node]
        set n14 [$ns node]
        set n15 [$ns node]
        set n16 [$ns node]
        set n17 [$ns node]

#Create duplex links between the nodes
        #****** GOLD LINKS ******#
        $ns duplex-link $n8 $n0 1Mb 20ms DropTail
        $ns duplex-link $n9 $n1 1Mb 20ms DropTail
        $ns duplex-link $n5 $n10 1Mb 20ms DropTail
        $ns duplex-link $n5 $n11 1Mb 20ms DropTail
        $ns duplex-link $n5 $n12 1Mb 20ms DropTail
        $ns duplex-link $n5 $n13 1Mb 20ms DropTail
        $ns duplex-link $n6 $n14 1Mb 20ms DropTail
        $ns duplex-link $n6 $n15 1Mb 20ms DropTail
        $ns duplex-link $n7 $n16 1Mb 20ms DropTail
        $ns duplex-link $n7 $n17 1Mb 20ms DropTail
        
        $ns queue-limit $n8 $n0 20
        $ns queue-limit $n9 $n1 20
        $ns queue-limit $n5 $n10 20
        $ns queue-limit $n5 $n11 20
        $ns queue-limit $n5 $n12 20
        $ns queue-limit $n5 $n13 20
        $ns queue-limit $n6 $n14 20
        $ns queue-limit $n6 $n15 20
        $ns queue-limit $n7 $n16 20
        $ns queue-limit $n7 $n17 20
        
        #****** PURPLE LINKS ******#
        $ns duplex-link $n0 $n2 2Mb 40ms DropTail
        $ns duplex-link $n1 $n2 2Mb 40ms DropTail
        $ns duplex-link $n3 $n5 2Mb 40ms DropTail
        $ns duplex-link $n4 $n6 2Mb 40ms DropTail
        $ns duplex-link $n4 $n7 2Mb 40ms DropTail
        
        $ns queue-limit $n0 $n2 25
        $ns queue-limit $n1 $n2 25
        $ns queue-limit $n3 $n5 25
        $ns queue-limit $n4 $n6 25
        $ns queue-limit $n4 $n7 25
        
        #****** BLACK LINKS ******#
        $ns duplex-link $n2 $n3 8Mb 100ms DropTail
        $ns duplex-link $n2 $n4 8Mb 100ms DropTail
        $ns duplex-link $n3 $n4 8Mb 100ms DropTail
        
        $ns queue-limit $n2 $n3 30
        $ns queue-limit $n2 $n4 30
        $ns queue-limit $n3 $n4 30

#Create Traffic
        #****** BLUE TRAFFIC ******#
        #Create a UDP agent and attach it to node 9
        set udp12 [new Agent/UDP]
        set udp13 [new Agent/UDP]
        set udp15 [new Agent/UDP]
        set udp17 [new Agent/UDP]
        $ns attach-agent $n9 $udp12
        $ns attach-agent $n9 $udp13
        $ns attach-agent $n9 $udp15
        $ns attach-agent $n9 $udp17

        # Create CBR traffic sources and attach them to UDPs
        set cbr12 [new Application/Traffic/CBR]
        $cbr12 set packetSize_ 1000
        $cbr12 set interval_ 0.005
        $cbr12 set random_ 1
        $cbr12 attach-agent $udp12
        set cbr13 [new Application/Traffic/CBR]
        $cbr13 set packetSize_ 3000
        $cbr13 set interval_ 0.005
        $cbr13 set random_ 1
        $cbr13 attach-agent $udp13
        set cbr15 [new Application/Traffic/CBR]
        $cbr15 set packetSize_ 2000
        $cbr15 set interval_ 0.005
        $cbr15 set random_ 1
        $cbr15 attach-agent $udp15
        set cbr17 [new Application/Traffic/CBR]
        $cbr17 set packetSize_ 2000
        $cbr17 set interval_ 0.005
        $cbr17 set random_ 1
        $cbr17 attach-agent $udp17

        #Create LossMonitor agents and attach them to nodes and udps
        set lm12 [new Agent/LossMonitor]
        set lm13 [new Agent/LossMonitor]
        set lm15 [new Agent/LossMonitor]
        set lm17 [new Agent/LossMonitor]
        $ns attach-agent $n12 $lm12
        $ns attach-agent $n13 $lm13
        $ns attach-agent $n15 $lm15
        $ns attach-agent $n17 $lm17
        $ns connect $udp12 $lm12
        $ns connect $udp13 $lm13
        $ns connect $udp15 $lm15
        $ns connect $udp17 $lm17
        
        #Set flow id for each traffic
        $udp12 set fid_ 12
        $udp13 set fid_ 13
        $udp15 set fid_ 15
        $udp17 set fid_ 17


        #****** RED TRAFFIC ******#
        #Create a TCP agent and attach it to nide 8
        set tcp10 [new Agent/TCP]
        set tcp11 [new Agent/TCP]
        set tcp14 [new Agent/TCP]
        set tcp16 [new Agent/TCP]
        $tcp10 set class_ 2
        $tcp11 set class_ 2
        $tcp14 set class_ 2
        $tcp16 set class_ 2
        $ns attach-agent $n8 $tcp10
        $ns attach-agent $n8 $tcp11
        $ns attach-agent $n8 $tcp14
        $ns attach-agent $n8 $tcp16

        # Create a CBR traffic sources and attach them to TCPs
        set cbr10 [new Application/Traffic/CBR]
        $cbr10 set packetSize_ 1000
        $cbr10 set interval_ 0.005
        $cbr10 set random_ 1
        $cbr10 attach-agent $tcp10
        set cbr11 [new Application/Traffic/CBR]
        $cbr11 set packetSize_ 3000
        $cbr11 set interval_ 0.005
        $cbr11 set random_ 1
        $cbr11 attach-agent $tcp11
        set cbr14 [new Application/Traffic/CBR]
        $cbr14 set packetSize_ 2000
        $cbr14 set interval_ 0.005
        $cbr14 set random_ 1
        $cbr14 attach-agent $tcp14
        set cbr16 [new Application/Traffic/CBR]
        $cbr16 set packetSize_ 2000
        $cbr16 set interval_ 0.005
        $cbr16 set random_ 1
        $cbr16 attach-agent $tcp16

        #Create TCPSink agents and attach them to nodes and TCPs
        set sink10 [new Agent/TCPSink]
        set sink11 [new Agent/TCPSink]
        set sink14 [new Agent/TCPSink]
        set sink16 [new Agent/TCPSink]
        $ns attach-agent $n10 $sink10
        $ns attach-agent $n11 $sink11
        $ns attach-agent $n14 $sink14
        $ns attach-agent $n16 $sink16
        $ns connect $tcp10 $sink10
        $ns connect $tcp11 $sink11
        $ns connect $tcp14 $sink14
        $ns connect $tcp16 $sink16
        
        #Set flow id for each traffic
        $tcp10 set fid_ 10
        $tcp11 set fid_ 11
        $tcp14 set fid_ 14
        $tcp16 set fid_ 16


#Schedule events
        #****** CBR NODE 8 (RED) START ******#
        $ns at 1.0 "$cbr10 start"
        $ns at 1.0 "$cbr11 start"
        $ns at 1.0 "$cbr14 start"
        $ns at 1.0 "$cbr16 start"
        
        #****** CBR NODE 9 (BLUE) START ******#
        $ns at 2.0 "$cbr12 start"
        $ns at 2.0 "$cbr13 start"
        $ns at 2.0 "$cbr15 start"
        $ns at 2.0 "$cbr17 start"

        #****** DOWN LINKS ******#
        $ns rtmodel-at 6.0 down $n2 $n3
        $ns rtmodel-at 7.0 up $n2 $n3
        
        #****** CBR NODE 8 (RED) STOP ******#
        $ns at 10.0 "$cbr10 stop"
        $ns at 10.0 "$cbr11 stop"
        $ns at 10.0 "$cbr14 stop"
        $ns at 10.0 "$cbr16 stop"
        
        #****** CBR NODE 9 (BLUE) STOP ******#
        $ns at 10.0 "$cbr12 stop"
        $ns at 10.0 "$cbr13 stop"
        $ns at 10.0 "$cbr15 stop"
        $ns at 10.0 "$cbr17 stop"
        
        #Call the finish procedure after 10.1 seconds of simulation time
        $ns at 10.1 "finish"

#Run the simulation
$ns run
