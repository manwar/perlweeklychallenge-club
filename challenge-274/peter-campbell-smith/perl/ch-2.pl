#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-06-17
use utf8;     # Week 274 - task 2 - Bus route
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

bus_route([12, 11, 41], [15, 5, 35]);
bus_route([12, 3, 41], [15, 9, 35], [30, 5, 25]);
bus_route([20, 0, 13], [15, 14, 15], [30, 15, 7]);

sub bus_route {
	
	my ($r, @interval, @offset, @duration, 
		@leave, @arrive, $take, $time, $best, $soonest, $routes);
	
	# import and show data
	$routes = @_;
	say qq[\nInput:\n    rt int off dur];
	for $r (0 .. $routes - 1) {
		($interval[$r], $offset[$r], $duration[$r]) = @{$_[$r]};
		printf("    %2d  %2d  %2d %3d\n", $r + 1, $interval[$r], $offset[$r], $duration[$r]);
	}
	
	say qq[Output:];
	say qq[    at take lv  ar  not lv  ar];
	
	# first departure in the hour
	for $r (0 .. $routes - 1) {
		$leave[$r] = $offset[$r];
	}
	
	# loop over minutes
	for $time (0 .. 59) {
		
		# get soonest arrival for this $time departure
		$soonest = 999;
		for $r (0 .. $routes - 1) {
			$leave[$r] += $interval[$r] if $leave[$r] < $time;
			$arrive[$r] = $leave[$r] + $duration[$r];
			
			if ($arrive[$r] < $soonest) {
				$soonest = $arrive[$r];
				$best = $r;
			}
		}
		
		# see if we can get there sooner by leaving later on another route
		for $r (0 .. $routes - 1) {
			if ($leave[$r] < $leave[$best] and $arrive[$r] > $arrive[$best]) {
				printf("    %02d    %d %02d %3d    %d %02d %3d\n", 
					$time, $best + 1, $leave[$best], $arrive[$best], $r + 1, $leave[$r], $arrive[$r]);
			}
		}
	}
}
