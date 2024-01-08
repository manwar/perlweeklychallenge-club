#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2024-01-01
use utf8;     # Week 250 task 2 - Alphanumeric string value
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

alpha_string_value('perl', '2', '000', 'python', 'r4ku');
alpha_string_value('001', '1', '000', '0001');
alpha_string_value('3', 'blind', 'mice', 'and', '10', 'green', 'bottles');

sub alpha_string_value {
	
	my (@a, $max, $s, $value);

	@a = @_;
	
	# loop over array elements and apply the stated rule
	$max = -1;
	for $s (@a) {
		$value = $s =~ m|^(\d+)$| ? $1 + 0 : length($s);
		$max = $value if $value > $max;
	}
	
	say qq[\nInput:  \@alphanumstr = ('] . join(q[', '], @a) . qq[')\nOutput: ] . $max;
}
