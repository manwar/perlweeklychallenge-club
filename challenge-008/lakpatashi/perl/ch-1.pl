#!/usr/bin/perl

use warnings;
use strict;

# part 1
# withIteration takes so much time to produce 5th element 
# so I used formula
my @primeList = (2,3,5,7,13,17,19); # 11 does not work
for my $i (@primeList){
	print 2**($i-1)*(2**$i-1),"\n";
}

#withIteration();

sub withIteration{	# should be called without parameter
	my $count = 0;
	my $n = 2;
	for (;;){
		#print "checking:: $n\n";
		if( isPerfect($n) ){
			print '='x10,"$n\n";
			$count++;
		}
		last if $count == 5;
		$n++;
	}
}

sub isPerfect{
	my ($n)= @_;
	my $divisorSum = 1;
	for (2..int sqrt $n){
		if ($_**2 == $n){
			$divisorSum += $_;
			return 0 if $divisorSum > $n;
		}else{
			$divisorSum += $_ + int $n/$_ unless $n % $_;	# add if divisor
		}
	}
	return 1 if $divisorSum == $n;
	return 0;
}

