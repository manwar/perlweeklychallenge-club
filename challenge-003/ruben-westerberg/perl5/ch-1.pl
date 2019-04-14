#!/usr/bin/env perl
#
#Smooth numbersI
my @primes=(2,3,5);
my $power=0;
while (1) {
	$power++;
	my @smooth=();
	my $t=60**$power;
	foreach my $s (1 .. ($t/2)-1) {
		foreach my $p (@primes) {
			#printf "Prime $p, $s\n";
			my $smooth1=$s*$p;	
			my $val=$t/$smooth1;
			my $test=($t%$smooth1);
			if (($test == 0) && ($val >= 2)) {
				#printf "smooth: $smooth1, val: $val test: $test\n";
				unless (grep $smooth1 == $_, @smooth) {
					push @smooth, $smooth1;
				}
				unless ( grep $val == $_, @smooth) {
					push @smooth, $val;
				}
				
			}
		}
	}
	
	printf "5-Smooth numbers for 60^$power\n";
	@smooth=sort { $a <=> $b} @smooth;
	foreach (@smooth) {
		printf "$_ ";
	}
	print"\n\n";
}
