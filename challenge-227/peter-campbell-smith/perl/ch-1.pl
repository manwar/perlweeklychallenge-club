#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-24
use utf8;     # Week 227 task 1 - Friday 13th
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

friday_13th(2023);
friday_13th(1945);
friday_13th(2012);
friday_13th(1753);
friday_13th(9999);

sub friday_13th {
	
	my ($target, $offset, $thirteenths);
	
	# 1 Jan is:      sun     mon     tue     wed     thu     fri     sat
	$thirteenths = [[2, 3], [2, 2], [2, 1], [1, 2], [3, 2], [1, 1], [1, 1]];
	
	$target = $_[0];
	$offset = -1;
	
	# 1 Jan moves forward 1 day, or 2 days if previous year was leap
	$offset += is_leap($_- 1) ? 2 : 1 for 1753 .. $target;

	say qq[\nInput:  $target\nOutput: ] . $thirteenths->[$offset % 7]->[is_leap($target)];
}

sub is_leap {  # returns 1 for leap year, 0 for non-leap
	
	#                      non-century year      century year 
	return ($_[0] % 100 ? ($_[0] % 4 ? 0 : 1) : ($_[0] % 400 ? 0 : 1));
}	

