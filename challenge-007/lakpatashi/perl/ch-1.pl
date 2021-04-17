#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

# PART 1
for my $i (1..50){
	my $digitSum = sum split( //,$i);
	print "$i\n" unless $i % $digitSum;
}
