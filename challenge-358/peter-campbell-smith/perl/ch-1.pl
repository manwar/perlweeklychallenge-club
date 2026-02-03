#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-26
use utf8;     # Week 358 - task 1 - Max str value
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

max_str_value('abc', 'de', 'fghi');
max_str_value('0012', '99', 'a1b2c');
max_str_value('hello123', '2026', 'perl');
max_str_value('', '00000', 'x y');
max_str_value('1', '002', '4.0', '');
max_str_value(1, 2, 'ÄäÖöÜüß');
max_str_value('5', 'gold', 'rings', '4', 'calling', 
	'birds', 3, 'French', 'hens', 2, 'turtle', 'doves');
max_str_value('0', '');

sub max_str_value {
	
	my (@strings, @max, $string, $value);
	
	# initialise
	@strings = @_;
	@max = (-1, '');
	
	# loop over values
	for $string (@strings) {
		$value = $string =~ m|^[0-9]+$| ? $string : length($string);
		@max = ($value, $string) if $value > $max[0];
	}
	
	# report
	say qq[\nInput:  ('] . join(q[', '], @strings) . q[')];
	say qq[Output: $max[0] ('$max[1]')];
}
