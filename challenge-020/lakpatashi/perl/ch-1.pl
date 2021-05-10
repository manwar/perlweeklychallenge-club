#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);

#part 1
my ($str) = shift;
my @arr = split //,$str;
my $char = shift @arr;
print $char;
for my $x (@arr){
	if($x ne $char){
		print " ";
		$char = $x;
	}
	print $x;
}


