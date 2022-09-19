#!/usr/bin/perl

use PDL;
use PDL::NiceSlice;

my $x=pdl(2);

for (1 .. 9) { $x = $x->append($x($_-1)*($x($_-1)-1)+1) } 

print $x,"\n"; 

