#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-08-14
use utf8;     # Week 229 task 1 - Separate digits
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

separate_digits(1, 34, 5, 6);
separate_digits(123, 9876, 2, 99999, 0);

sub separate_digits {
	
	say qq[\nInput:  (] . join(', ', @_) . ')';
	say qq[Output: (] . join(', ', split('', join('', @_))) . ')';;
}