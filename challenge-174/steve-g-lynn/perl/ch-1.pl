#!/usr/bin/env perl

#real	3m31.183s
#user	3m29.832s
#sys	0m0.179s

#-- this PDL solution is slow. The alternative
#-- plain Perl solution in alt-ch-1,pl runs in ~8 seconds. 

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

#--make PDL aware of the user-defined fn signature so it broadcasts correctly

broadcast_define('get_poly(a();[o]b())', over { $_[1] .= _get_poly($_[0]); });

#-- now find the sequence by checking ints up to 3_000_000

my $pdl=sequence(long, 3_000_000);
&get_poly($pdl, (my $out=null) );
print $pdl->where($pdl==$out),"\n";

#[0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427 2646798]

#-- subroutine
#-- given base-10 integer abc.. return a^1+b^2+c^3...
sub _get_poly {
	my $a=pdl split(//,$_[0]);
	return sum($a ** ( ($a->xvals) + 1) );
}

