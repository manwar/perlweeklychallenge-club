#!/usr/bin/perl

use strict;
use warnings;

# PART 1
my $range = 5;	#max exponent of each prime factor
my @arr;
for my $i (0..$range){
	for my $j (0..$range){
		for my $k (0..$range){
		push @arr, 2**$i * 3**$j * 5**$k;
		}
	}
}
print join ' ',sort {$a<=>$b} @arr;
print "\n";


