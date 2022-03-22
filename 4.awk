BEGIN {
#include<stdio.h>
pkt=0;time=0;
}
{
if ($1="r" && $3 == "0" && $4=="6")
{
pkt = pkt + $6;
time = $2;
}
}
END {
printf("throughput=%d",(pkt/time)*(8/100000));
}

