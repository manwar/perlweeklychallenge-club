#!/usr/bin/raku

# time:
#
#real	0m41.596s
#user	0m41.284s
#sys	0m0.215s

use Statistics; 

my @test = ();
for (1..998_438) {
	push @test, rand;
}

say &fivenum(@test); #-- ready-made library function

#(2.9838094933731796e-06 0.24999500930783614 0.5003205594513298
#0.750393377736879 0.9999998988183594)
#
#-- for a large sample from a uniform distribution over [0,1], 
#--- asymptotically will be equal to (0, 0.25, 0.5, 0.75, 1).

