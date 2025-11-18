#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-17
use utf8;     # Week 348 - task 2 - Convert time
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

convert_time('02:30', '02:45');
convert_time('11:55', '12:15');
convert_time('09:00', '13:00');
convert_time('23:45', '00:30');
convert_time('14:20', '15:25');
convert_time('00:00', '23:59');

sub convert_time {
	
	my ($from, $till, @chunks, $from_mins, $till_mins, $gap, $j, $ops, $explain);
	
	# initialise
	($from, $till) = @_;
	@chunks = (60, 15, 5, 1);
	$explain = '';
	
	# convert to minutes since midnight
	$from_mins = substr($from, 0, 2) * 60 + substr($from, 3, 2);
	$till_mins = substr($till, 0, 2) * 60 + substr($till, 3, 2);
	$till_mins += 24 * 60 if $till_mins < $from_mins;
	$gap = $till_mins - $from_mins;
	
	# analyse difference
	$ops = 0;
	for $j (0 .. 3) {
		while ($gap >= $chunks[$j]) {
			$gap -= $chunks[$j];
			$ops ++;
			$explain .= qq[$chunks[$j] + ];
		}
	}	
	
	say qq[\nInput:  \$source = '$from', \$target = '$till'];
	say qq[Output: $ops : ] . substr($explain, 0, -2);
}
