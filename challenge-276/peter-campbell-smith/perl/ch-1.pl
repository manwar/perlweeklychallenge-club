#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-01
use utf8;     # Week 276 - task 1 - Complete day
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@hours);

complete_day(12, 12, 30, 24, 24);
complete_day(72, 48, 24, 5);
complete_day(12, 18, 24);

push @hours, int(rand(30)) for 0 .. 24;
complete_day(@hours);

sub complete_day {
	
	my (@hours, $pairs, $a, $b, $days, $explain);
	
	@hours = @_;
	
	# loop over all pairs
	$pairs = 0;
	$explain = '';
	for $a (0 .. @hours - 2) {
		for $b ($a + 1 .. @hours - 1) {
			
			# determine if this pair sums to a whole number of days
			$days = ($hours[$a] + $hours[$b]) / 24; 
			next unless (int($days) == $days);
			$pairs ++;
			$explain .= qq[($hours[$a] + $hours[$b]), ];
		}
	}
	printf(qq[\nInput:  \@hours = (%s)\n], join(', ', @hours));
	printf(qq[Output: %s: %s\n], $pairs, substr($explain, 0, -2));
}
