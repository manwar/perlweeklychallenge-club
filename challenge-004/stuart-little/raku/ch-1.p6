#!/usr/bin/env perl6
use v6;

my $s=$*PROGRAM-NAME.IO.s;
my @a=(1..5*$s);

say (2*(1+([\*] (@a.map(*.FatRat) Z/ @a.map(2 * * +1).map(*.FatRat))).sum)).substr(0,$s);

=finish
run as <script>
uses the double-factorial series
ref: https://en.wikipedia.org/wiki/Approximations_of_%CF%80#Arctangent
