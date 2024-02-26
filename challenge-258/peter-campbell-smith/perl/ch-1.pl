#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-02-26
use utf8;     # Week 258 - task 1 - Count even digits number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

count_even_digits_number (10, 1, 111, 24, 1000);
count_even_digits_number (111, 1, 11111);
count_even_digits_number (2, 8, 1024, 256);
count_even_digits_number (1234567890123456789901234567890,
	12345678901234567890, 123456789);

sub count_even_digits_number {
	
	# count @ints with even length
	my $count = 0;
	$count +=  1 - (length($_) % 2) for @_;
	
	say qq[\nInput: (] . join(', ', @_) . ')';
	say qq[Output: $count];
}
