#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;

# part 2

my %hash;

my $n = 2;
for (;;){
	#print "checking:: $n\n";
	my $val = divisorSum($n);
	if( $val > 1 ){
		if( divisorSum($val)==$n and $val != $n){
			print "found min pair:: ($n,$val)\n";
			last;
		}
	}
	#print "$n\n";
	last if $n == 1000;
	$n++;
}

sub divisorSum{
	my ($n)= @_;
	my $divisorSum = 1;
	for (2..int sqrt $n){
		if ($_**2 == $n){
			$divisorSum += $_;
		}else{
			$divisorSum += $_ + int $n/$_ unless $n % $_;	# add if divisor
		}
	}
	return $divisorSum;
}

