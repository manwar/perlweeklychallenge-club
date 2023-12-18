#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-12-18
use utf8;     # Week 248 task 1 - Shortest distance
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

shortest_distance('loveleetcode', 'e');
shortest_distance('We wish you a merry christmas and a happy new year!', 'a');
shortest_distance('zoos contain animals', 'z');
shortest_distance('tornadoes have a vortex', 'x');
shortest_distance('xylophones and zithers', 'q');

sub shortest_distance {
	
	my ($string, $char, @letters, $last, @count, @dist, $j, $count, $i, $k);
	
	($string, $char) = @_;
	
	# initialise
	@letters = split('', $string);
	$last = @letters - 1;
	$dist[$_] = 999 for 0 .. $last;
	$count = 999;
	
	# go along string forwards and backwards
	for $k (0, 1) {
		for $j (0 .. $last) {
			$i = $k ? $j : $last - $j;
			
			# if we've found a $char reset count to 0
			if ($letters[$i] eq $char) {
				$count = $dist[$i] = 0;
				
			# or save the distance to the nearest $char	
			} else {
				$count ++;
				$dist[$i] = $count if $count < $dist[$i];
			}
		}
	}
	say qq[\nInput:  \@string = '$string', \$char = '$char'];
	say qq[Output: ] . ($dist[0] != 999 ? join(', ', @dist) : qq['$char' does not occur in '$string']);	
}
