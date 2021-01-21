#!/usr/bin/env perl

# Challenge 096
#
# TASK #2 › Edit Distance
# Submitted by: Mohammad S Anwar
# You are given two strings $S1 and $S2.
# 
# Write a script to find out the minimum operations required to convert $S1
# into $S2. The operations can be insert, remove or replace a character. Please
# check out Wikipedia page for more information.
# 
# Example 1:
# Input: $S1 = "kitten"; $S2 = "sitting"
# Output: 3
# 
# Operation 1: replace 'k' with 's'
# Operation 2: replace 'e' with 'i'
# Operation 3: insert 'g' at the end
# Example 2:
# Input: $S1 = "sunday"; $S2 = "monday"
# Output: 2
# 
# Operation 1: replace 's' with 'm'
# Operation 2: replace 'u' with 'o'

# NOTE: the  Wagner-Fischer Distance algorithm builds a table of distances 
#		from which the operations can be deduced

use strict;
use warnings;
use 5.030;
use List::Util 'min';

use Data::Dump 'dump';

wag_fis_dist(@ARGV);

sub wag_fis_dist {
	my($a, $b) = @_;

	# define a table where d[i,j] is the Levenshtein distance between 
	# first i chars of $a and first j chars of $b
	my @d;
	$d[0][0] = 0;
	
	# source prefixes can be transformed into empty string by dropping chars
	$d[$_][0] = $_ for (1 .. length($a));

	# target prefixes can be reached from empty source prefix by inserting chars
	$d[0][$_] = $_ for (1 .. length($b));
	
	# flood-fill the rest of the table
	for my $j (1 .. length($b)) {
		for my $i (1 .. length($a)) {
			my $subst_cost = 
				(substr($a,$i-1,1) eq substr($b,$j-1,1)) ? 0 : 1;
			$d[$i][$j] = min($d[$i-1][$j]+1,				# deletion
							 $d[$i][$j-1]+1,				# insertion
							 $d[$i-1][$j-1]+$subst_cost);	# substitution
		}
	}
	
	# distance is in lower bottom cell
	say $d[length($a)][length($b)];
	
	# traverse the minimum path
	my($i, $j, $step) = (0,0,0);
	while ($i < length($a) || $j < length($b)) {
		my($min_dir, $min_delta) = ('', 1e10);
		my($dir, $delta);
		
		# search shortest path in priority SE, E, S
		if ($i < length($a) && $j < length($b)) {
			($dir, $delta) = ("SE", $d[$i+1][$j+1] - $d[$i][$j]);
			($min_dir, $min_delta) = ($dir, $delta) if $delta < $min_delta;
		}
		
		if ($j < length($b)) {
			($dir, $delta) = ("E", $d[$i][$j+1] - $d[$i][$j]);
			($min_dir, $min_delta) = ($dir, $delta) if $delta < $min_delta;
		}
			
		if ($i < length($a)) {
			($dir, $delta) = ("S", $d[$i+1][$j] - $d[$i][$j]);
			($min_dir, $min_delta) = ($dir, $delta) if $delta < $min_delta;
		}
		
		# apply shortest path and show steps
		if ($min_dir eq "SE") {
			($i, $j) = ($i+1, $j+1);
			my $from = substr($a,$i-1,1);
			my $to = substr($b,$j-1,1);
			if ($from ne $to) {
				say "Operation ", ++$step, ": replace '$from' with '$to'";
			}
		}
		elsif ($min_dir eq "E") {
			($i, $j) = ($i, $j+1);
			my $add = substr($b,$j-1,1);
			say "Operation ", ++$step, ": insert '$add' ",
				($j==length($b)) ? "at end" : "at position $j";
		}
		elsif ($min_dir eq "S") {
			($i, $j) = ($i+1, $j);
			my $del = substr($a,$i-1,1);
			say "Operation ", ++$step, ": delete '$del' ",
				($i==length($a)) ? "at end" : "at position $i";
		}
		else { 
			die $min_dir;
		}
	}	
}
