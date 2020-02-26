#!/usr/bin/perl

use strict;
use warnings;

my @rooms;
my $number;
my $size = 500;
#0 is closed
#1 is opened
foreach (my $i = 0; $i < $size; $i++) {
	@rooms[$i] = 0;
}

foreach (my $j = 0; $j < $size; $j++) {
	
	foreach (my $k = $j; $k < $size; $k = $j + $k +1) {
		#If closed
		if (@rooms[$k] == 0) {
			@rooms[$k] = 1;
		}
		else {
			@rooms[$k] = 0;
		}		
	}	
}

print "The followings rooms are still open:\n";

foreach (my $x = 0; $x < $size; $x++) {
	$number = $x +1;
	if (@rooms[$x] == 1) {
		print "The room $number\n";
	}	
}










