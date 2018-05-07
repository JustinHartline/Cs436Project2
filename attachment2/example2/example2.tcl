#Create a simulator object
set ns [new Simulator]


#Create a trace file
set tracefd [open example2.tr w]
$ns trace-all $tracefd


#Create two nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

#Create duplex links between the nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n1 $n4 1Mb 10ms DropTail

#Set Queue Size of links to 10
$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 10
$ns queue-limit $n1 $n3 10
$ns queue-limit $n1 $n4 10


#Create a UDP agent for each traffic source and attach it to node n0
set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]
set udp2 [new Agent/UDP]
$ns attach-agent $n0 $udp0
$ns attach-agent $n0 $udp1
$ns attach-agent $n0 $udp2

#Set flow id for each traffic
$udp0 set fid_ 0
$udp1 set fid_ 1
$udp2 set fid_ 2


# Create a CBR generator for each traffic source and attach it to its udp agent
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 300
$cbr0 set interval_ 0.005
$cbr0 set random_ 1
$cbr0 attach-agent $udp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 set random_ 1
$cbr1 attach-agent $udp1

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 1000
$cbr2 set interval_ 0.005
$cbr2 set random_ 1
$cbr2 attach-agent $udp2

#Create a LossMonitor agent (a traffic sink) for each traffic and attach it to node n4
set sink0 [new Agent/LossMonitor]
set sink1 [new Agent/LossMonitor]
set sink2 [new Agent/LossMonitor]
$ns attach-agent $n2 $sink0
$ns attach-agent $n3 $sink1
$ns attach-agent $n4 $sink2

#Connect the traffic sources to the traffic sinks
$ns connect $udp0 $sink0
$ns connect $udp1 $sink1
$ns connect $udp2 $sink2

#Schedule events for the CBR agent
$ns at 0 "$cbr0 start"
$ns at 0 "$cbr1 start"
$ns at 0 "$cbr2 start"
$ns at 5 "$cbr0 stop"
$ns at 5 "$cbr1 stop"
$ns at 5 "$cbr2 stop"

$ns at 5 "exit 0"

#Run the simulation
$ns run
