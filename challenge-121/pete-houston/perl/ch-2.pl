#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12102.pl
#
#        USAGE: ./12102.pl [ num_cities ]
#
#  DESCRIPTION: Travelling Salesman Problem
#               Outputs a naive (fast) solution which is good but will
#               not necessarily produce the shortest route.
#               Also outputs a brute-force (slow) solution which does
#               produce the shortest route.
#
#      OPTIONS: Specify num_cities for an additional random network of
#               that many nodes.
# REQUIREMENTS: Time::HiRes, Math::Combinatorics
#        NOTES: Takes 40s to run brute force with num_cities = 11. 
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/07/21
#===============================================================================

use strict;
use warnings;
use Time::HiRes qw/gettimeofday tv_interval/;
use Math::Combinatorics;

my @distances = (
	[0, 5, 2, 7],
	[5, 0, 5, 3],
	[3, 1, 0, 6],
	[4, 5, 4, 0]
);

my ($len, $route, $timing) = naive (@distances);
print "Naive solver on sample cities\nDistance: $len, Route: $route\nCompute time: ${timing}s\n\n";

($len, $route, $timing) = brute_force (@distances);
print "Brute force solver on sample cities\nDistance: $len, Route: $route\nCompute time: ${timing}s\n\n";

my $nc = shift or exit;
print "\nAnd now a set of $nc cities with random distances:\n";
@distances = ();
chop (my $fmt = '%2i ' x $nc);
for (1 .. $nc) {
	my @row;
	push @row, int rand 50 for 1 .. $nc;
	$row[$_ - 1] = 0;
	printf "  [$fmt]\n", @row;
	push @distances, \@row;
}

($len, $route, $timing) = naive (@distances);
print "Naive solver for $nc cities\nDistance: $len, Route: $route\nCompute time: ${timing}s\n\n";

($len, $route, $timing) = brute_force (@distances);
print "Brute force solver for $nc cities\nDistance: $len, Route: $route\nCompute time: ${timing}s\n";

sub naive {
	# Naive solver, takes the shortest step each time to a place we have
	# not been
	my $starttime = [gettimeofday];
	my @d = @_;

	# Start does not matter, so pick 0
	my @route = 0;
	my %targets;
	@targets{(1 .. $#d)} = (1) x $#d;
	my $dist  = 0;

	while (keys %targets) {
		my (@fore, @aft);
		for (0 .. $#d) {
			next unless $targets{$_};
			push @fore, [$_, $d[$route[-1]]->[$_]] unless $_ == $route[-1];
			push @aft,  [$_, $d[$_]->[$route[0]]]  unless $_ == $route[0];
		}
		if ($#fore < 1) {
			if ($fore[0][0] < $aft[0][0]) {
				$dist += $fore[0][1];
				push @route, $fore[0][0]
			} else {
				$dist += $aft[0][1];
				unshift @route, $aft[0][0]
			}
			last;
		}
		# Sort them by ascending distance
		@fore = sort { $a->[1] <=> $b->[1] } @fore;
		@aft  = sort { $a->[1] <=> $b->[1] } @aft;
		my $fgo = my $ago = 0;
		# If both nearest are the same, look at the next
		if ($fore[0][0] == $aft[0][0]) {
			if ($fore[1][1] - $fore[0][0] < $aft[1][1] - $aft[0][0]) {
				$fgo = 1;
			} else {
				$ago = 1;
			}
		}

		push @route, $fore[$fgo][0];
		unshift @route, $aft[$ago][0];
		$dist += $fore[$fgo][1] + $aft[$ago][1];
		delete @targets{$fore[$fgo][0], $aft[$ago][0]};
	}

	# Complete the circuit
	if ($route[0] != $route [-1]) {
		$dist += $d[$route[-1]][$route[0]];
		push @route, $route[0];
	}

	return ($dist, join (', ', @route), tv_interval ($starttime));
}

sub brute_force {
	my $starttime = [gettimeofday];
	my @d = @_;
	
	# Always go 0 to 0, just change around the intermediate steps. This
	# makes it O((n-1)!) which is not going to scale well.
	my $combo = Math::Combinatorics->new (count => $#d, data => [1 ..  $#d]);
	my @route;
	my $len;
	
	while (my @perm = $combo->next_permutation) {
		my $dist = $d[0][$perm[0]];
		for my $i (0 .. $#perm - 1) {
			$dist += $d[$perm[$i]][$perm[$i+1]];
		}
		$dist += $d[$perm[-1]][0];
		if (!defined ($len) || $dist < $len) {
			@route = (0, @perm, 0);
			$len = $dist;
		}
	}
	return ($len, join (', ', @route), tv_interval ($starttime));
}
