#!/usr/bin/env perl
#
# Write a script to find Jaro-Winkler distance between two strings. For more
# information check wikipedia page.
# (https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance)
################################################################################

use strict;
use warnings;

use List::Util qw<max min>;

sub jaro {
	my @s1 = split //, shift;
	my @s2 = split //, shift;

	# Two chars in s1 and s2 match if they are not farther away than this number
	my $match_dist = int(max (scalar @s1, scalar @s2) / 2)-1;
	$match_dist = 0 if $match_dist < 0;

	# Maps indices from s1 chars to matching s2 chars
	my %matches;

	# Compute matches (fill the %matches hash)
	S1:
	foreach my $i (0 .. $#s1) {
		foreach my $j ($i-min($i, $match_dist) .. min($i+$match_dist, $#s2)) {
			# Skip s2 char if already matched
			next if grep(/$j/, values %matches);

			# If characters match, store match and advance to next char in s1
			if ($s1[$i] eq $s2[$j]) {
				$matches{$i} = $j;
				next S1;
			}
		}
	}

	# Count number of matches and exit if 0
	my $m = keys %matches;
	return 0 if $m == 0;

	# Count transpositions
	my $t = 0;
	for my $k (keys %matches) {
		$t += 1 if $k != $matches{$k};
	}

	# Finally compute and return Jaro distance
	return (($m/@s1) + ($m/@s2) + (($m-$t)/$m))/3;
}

sub jaro_winkler {
	my ($s1, $s2) = @_;
	my $jarosim = jaro $s1, $s2;
	my $l;
	for ($l = 0; $l < length $s1; $l++) {
		last if (substr($s1, $l, 1) ne (substr $s2, $l, 1));
	}
	my $p = 0.1;
	return $jarosim + $l*$p*(1-$jarosim);
}

die "Usage: $0 <s1> <s2>" unless @ARGV == 2;
print jaro_winkler(@ARGV), "\n";
