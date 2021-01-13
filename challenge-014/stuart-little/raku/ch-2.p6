#!/usr/bin/env perl6
use v6;

my @states=$=finish.lines;
my @words=@*ARGS[0].IO.lines;

say @words.grep((*.uc.comb(2) (-) @states).elems==0).classify(*.chars).max(*.key).value

# run as <script> <path to file containing list of dict words>

=finish
AL
AK
AZ
AR
CA
CO
CT
DE
DC
FL
GA
HI
ID
IL
IN
IA
KS
KY
LA
ME
MD
MA
MI
MN
MS
MO
MT
NE
NV
NH
NJ
NM
NY
NC
ND
OH
OK
OR
PA
RI
SC
SD
TN
TX
UT
VT
VA
WA
WV
WI
WY
