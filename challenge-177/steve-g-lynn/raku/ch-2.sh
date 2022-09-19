#!/bin/sh

#real	0m2.907s
#user	0m3.050s
#sys	0m0.047s

raku -e '(^Inf).grep(*.is-prime).grep(*.chars !%% 2 ).grep({$_.comb.sort.head(2).sum > 0}).grep({substr($_,$_.chars/2,1)==0}).grep({substr($_,0,(($_.chars)/2).floor) == substr($_.flip,0,(($_.chars)/2).floor) }).head(20).say'

#(101 16061 31013 35053 38083 73037 74047 91019 94049 1120211 1150511
# 1160611 1180811 1190911 1250521 1280821 1360631 1390931 1490941 1520251)

