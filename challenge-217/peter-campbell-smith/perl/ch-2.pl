#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-15
use utf8;     # Week 216 task 1 - Max number
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

max_number(1, 23);
max_number(10, 3, 2);
max_number(31, 2, 4, 10);
max_number(5, 11, 4, 1, 2);
max_number(1, 10);

sub max_number {
	
	# concatenate the numbers in descending alphabetical sort order
	say qq[\nInput:  ] . join(', ', @_);
	say qq[Output: ] . join('', reverse sort @_);
}

