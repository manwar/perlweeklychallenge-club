#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);

#part 2
my @arr;
my $n = 3;
for (my $i =0; $i < $n; $i++){
	for (my $j =0; $j < $n; $j++){
		$arr[$i][$j] = $i==$j? 1 : 0;
	}
}


for my $line (@arr){
	print join(' ',@{$line}	),"\n";
}
