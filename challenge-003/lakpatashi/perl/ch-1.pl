#!/usr/bin/perl

use v5.10;
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



sub v2 {
	my ($a,$b,$c) = (5,3,2);
	for my $num (0..7){
		#say $num;
		my ($i,$j,$k) = split //, sprintf("%03b", $num);
		say ( $a**$i * $b**$j * $c**$k );
	}
}
