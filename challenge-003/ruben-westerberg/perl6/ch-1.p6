#!/usr/bin/env perl6
#
my $powers=(1 ... *) ;
my $primes=(2,3,5);
for $powers<> {
	my $smooth=[];
	my $t=60**$_;
		for 1..($t/2) -> $s {
			append $smooth,
				((do for $primes<> -> $p {
					my $smooth1=$s*$p;
					my $val=Int($t/$smooth1);
					my $test= ($t%%($smooth1));
					($test && ($val >= 2)) ?? ($smooth1,$val) !! ();
					}).flat);
	}
	say "5-Smooth Numbers for 60^$_: ";
	say $smooth.Bag.pairs>>.key.sort.join: " ";
	say "";
	sleep 1;

}
