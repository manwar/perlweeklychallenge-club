#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-17
use utf8;     # Week 213 task 2 - Shortest route
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($shortest, $from_value, $to_value, $routes, @nodes, $best, $best_journey);

shortest_route(1, 9, [[1, 2, 3, 4], [4, 5, 6, 7, 8, 9]]);
shortest_route(1, 3, [[1, 2, 7, 7, 7, 3, 4],[2, 4]]);
shortest_route(1, 9, [[1, 2, 3],[3, 4, 5],[5, 6, 9]]);
shortest_route(1, 9, [[9, 8, 7], [5, 6, 7], [1, 2, 5]]);
shortest_route(1, 9, [[1, 2, 3, 9], [1, 5, 9]]);
shortest_route(1, 9, [[1, 2, 3, 6], [1, 2, 3, 4, 7], [1, 2, 3, 4, 5, 9]]);

sub shortest_route {
	
	my ($r, $p, $o, $distance, $j, $v, $s, @starts, $rubric, $journey);
	
	# initialise
	$from_value = $_[0];
	$to_value = $_[1];
	$routes = $_[2];
	$best = 1e6;
	@nodes = ();
	
	# show input
	print qq[\nInput:  \@routes      = (];
	for $r (0 .. scalar @$routes - 1) {
		$rubric .= qq{[} . join(', ', @{$routes->[$r]}) . q{], };
	}
	say substr($rubric, 0, -2) . ')';
	say qq[        \$source      = $from_value];
	say qq[        \$destination = $to_value];		

	# index all points by value and identifiy possible starts
	$j = 0;
	for $r (0 .. scalar @$routes - 1) {
		for $p (0 .. scalar @{$routes->[$r]} - 1) {
			$v = $routes->[$r]->[$p];
			$nodes[$v] .= qq[$r,$p!];
			$starts[$j ++] = qq[$r,$p] if $v == $from_value;
		}
	}

	# discard values not on >1 route, thus leaving only nodes
	for $v (0 .. scalar @nodes - 1) {
		if (defined $nodes[$v]) {
			if ($nodes[$v] !~ m|!.+!|) {
				undef $nodes[$v];
			}
		}
	}
	
	# loop over all starting points
	$best_journey = '';
	for $s (@starts) {
		($r, $p) = split(',', $s);
		$journey = dist_to_target($r, $p, '', 0, qq[$from_value, ]);
	}
	if ($best < 1e6) {
		say qq[Output: \$distance    = $best];
		say qq[        \@journey     = (] . substr($best_journey, 0, -2) . ')';
	} else {
		say qq[Output: -1];
	}
		
}

sub dist_to_target {
	
	my ($route, $point, $p, $nodes, $distance, $avoid, $journey, $v, $r, $n,
		$distance2, $in_journey);
	
	($route, $point, $avoid, $distance, $journey) = @_;
	$in_journey = $journey;
	
	# check along route for target
	for $p (0 .. scalar @{$routes->[$route]} - 1) {
		
		# found target value
		if ($routes->[$route]->[$p] == $to_value) {
			$distance2 = $distance + abs($p - $point);
			
			# new best distance
			if ($distance2 < $best) {
				
				# add last step to journey
				if ($p > $point) {
					for ($n = $point + 1; $n <= $p; $n ++) {
						$journey .= qq[$routes->[$route]->[$n], ];
					}
				} elsif ($p < $point) {
					for ($n = $point - 1; $n >= $p; $n --) {
						$journey .= qq[$routes->[$route]->[$n], ];
					}
				}
				
				# save result
				$best = $distance2;
				$best_journey = $journey;
			}
		}
	}
	
	# no target on this route so check along route for nodes
	for $n (0 .. scalar @{$routes->[$route]} - 1) {
		next if $n == $point;
		
		# check for unvisited nodes on this route
		$nodes = defined $nodes[$routes->[$route]->[$n]] ? $nodes[$routes->[$route]->[$n]] : '';
		next unless $nodes;
		while ($nodes =~ m|(\d+),(\d+)|g) {
			
			# get journey so far, avoid nodes already visited
			$journey = $in_journey;
			($r, $p) = ($1, $2);
			next unless $r != $route;
			next if $avoid =~ m|!$r,$p|;
			$avoid .= qq[!$r,$p!];
			
			# add points to journey
			if ($n > $point) {
				$in_journey = qq[${in_journey}$routes->[$route]->[$_], ] for ($point + 1 .. $n);
			} elsif ($n < $point) {
				for ($v = $point - 1; $v > $n; $v --) {					
					$in_journey = qq[$in_journey$routes->[$route]->[$v], ];
				}
			}
			
			# and recurse
			$journey = 
				dist_to_target($1, $2, $avoid, $distance + abs($n - $point), $in_journey);
		}
	}
	return $journey;
}
