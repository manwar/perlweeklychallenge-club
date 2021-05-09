#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);

#part 1
my $total = 100000;
my $maxIdx;
my $maxPart = 0;
for my $i (1..100){
	$i /= 100;
	my $part = $total*$i;
	if ($part > $maxPart){
		$maxPart = $part;
		$maxIdx = $i*100;
	}
	#print "$i ==> $part\n";
	$total -= $part;
}
print "Person $maxIdx gets larger part\n";

