Judah Perez, Justin Hartline
CS 436
NS Project 2
05/10/2017

Report

•	Submitted Files for this assignment:
o	Part 1
    Lostpkts.xlsx, Receivedpckts.xlsx, Sentpkts.xlsx, part1.awk
o	Part 2
    Avgdelay.xlsx, part2.awk
o	Part 3
    Jitter_flow11.xlsx, part3.awk
	

In Project 2, we continue parsing the simulation started in Project 1. We use the ns network simulation tool and AWK to parse tracefiles generated from our theoretical network. The project is separated into three parts that measures sent/received/lost packets, packet delay, and jitter, respectively. We simulated four workflows (8-11, 9-12, 8-16, 9-17) and each are included in every xls file.

Part 1:

The number of lost packets, sent packets, and received packets for all 4 workflows are plotted in a chart in each of the 3 xls files. We used 2 second increments to easily visualize the simulated network flows for 10 seconds. It sticks out immediately that there is a heavy workload on 9-17 and 9-12, as well as a large amount of lost packets.

Part 2:

In this part, we calculated the average delay for each workflow and plotted it on a chart in our Avgdelay.xlsx. Our delay stayed at a relatively consistent < 20ms, except for a spike at 1 second for workflow 8-16 up to 80 milliseconds.

Part 3: 

For this part, we measure jitter in our theoretical network. For all but one time interval, we stay under 100 milliseconds of jitter with a singular spike up to ~160 ms.

