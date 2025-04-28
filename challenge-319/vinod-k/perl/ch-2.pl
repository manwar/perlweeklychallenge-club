#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw/min/;

use Data::Dumper;

my @array_1 = (1, 2, 3, 4);
my @array_2 = (1, 5, 7, 8);
my @res = ();

foreach my $e1 (@array_1){
	foreach my $e2 (@array_2){
		if ($e1 == $e2){
			push (@res, $e1);
		}
	}
}

my $min;
if (scalar @res == 0) {
	$min = -1;
} else {
	$min = $res[0];
}

foreach my $element (@res){
	if ($element < $min){
		$min = $element;
	}
}
print "Min: $min\n";
