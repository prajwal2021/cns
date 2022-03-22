set ns [new Simulator]
set f [open 2.tr w]
$ns trace-all $f
set nf [open 2.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 0.01Mb 10ms DropTail
$ns duplex-link $n1 $n2 0.01Mb 10ms DropTail
$ns duplex-link $n2 $n3 0.01Mb 10ms DropTail
$ns duplex-link $n3 $n4 0.01Mb 10ms DropTail
$ns duplex-link $n4 $n5 0.01Mb 10ms DropTail
$ns duplex-link $n0 $n5 0.01Mb 10ms DropTail

Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id] received ping answer from $from with round-trip time $rtt ms."
}

set p(0) [new Agent/Ping]
$ns attach-agent $n0 $p(0)
set p(1) [new Agent/Ping]
$ns attach-agent $n1 $p(1)
set p(2) [new Agent/Ping]
$ns attach-agent $n2 $p(2)
set p(3) [new Agent/Ping]
$ns attach-agent $n3 $p(3)
set p(4) [new Agent/Ping]
$ns attach-agent $n4 $p(4)
set p(5) [new Agent/Ping]
$ns attach-agent $n5 $p(5)

$ns connect $p(0) $p(1)
$ns connect $p(1) $p(2)
$ns connect $p(2) $p(3)
$ns connect $p(3) $p(4)
$ns connect $p(4) $p(5)
$ns connect $p(5) $p(0)

for {set i 0} {$i<50} {incr i} {

$ns at 0.2 "$p(0) send"
$ns at 0.2 "$p(1) send"
$ns at 0.2 "$p(2) send"
$ns at 0.2 "$p(3) send"
$ns at 0.2 "$p(4) send"
$ns at 0.2 "$p(5) send"
}

proc finish {} {
global ns f nf
$ns flush-trace
close $f
close $nf
exec nam 2.nam &
exit 0
}
$ns at 1.0 "finish"
$ns run

