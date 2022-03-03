#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

declare -A p

p["PERL"]=1; p["PELR"]=1; p["PREL"]=1; p["PRLE"]=1; p["PLER"]=1; p["PLRE"]=1;
p["EPRL"]=1; p["EPLR"]=1; p["ERPL"]=1; p["ERLP"]=1; p["ELPR"]=1; p["ELRP"]=1;
p["REPL"]=1; p["RELP"]=1; p["RPEL"]=1; p["RPLE"]=1; p["RLEP"]=1; p["RLPE"]=1;
p["LERP"]=1; p["LEPR"]=1; p["LREP"]=1; p["LRPE"]=1; p["LPER"]=1; p["LPRE"]=1;

while read line; do unset "p[$line]"; done

for x in ${!p[@]}; do echo $x; done
