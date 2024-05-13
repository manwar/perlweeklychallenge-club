#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-13
use utf8;     # Week 269 - task 1 - Bitwise or
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

bitwise_or(1, 2, 3, 4, 5);
bitwise_or(2, 3, 9, 16);
bitwise_or(1, 2, 5, 7, 9);
bitwise_or(1, 3, 3, 7, 5, 9, 19, 20, 99, 100);
bitwise_or(1, 3, 3, 7, 5, 9, 19, 20, 99, 101);

sub bitwise_or {
	
	# filter out even numbers
	my @result = grep { ! ($_ & 1) } @_;
	
	# there are at least 2 of them if $result[1] is defined
	say sprintf(qq[\nInput:  \@ints = (%s)], join(', ', @_));
	say qq[Output: ] . ($result[1] ? qq[true ($result[0], $result[1])] : 'false');
}
