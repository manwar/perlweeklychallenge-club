#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12402.pl
#
#        USAGE: ./12402.pl N N [ ... ]
#
#  DESCRIPTION: Split the list of integers into two subsets with the
#               minimum difference in sums.
#
# REQUIREMENTS: List::Util, Math::Combinatorics, Array::Diff
#        NOTES: There may be more than one optimal solution for a given
#               input set. This program will only output one such
#               solution.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/08/21
#===============================================================================

use strict;
use warnings;
use List::Util 'sum';
use Math::Combinatorics;
use Array::Diff;

my @set = sort { $a <=> $b } @ARGV;
my $tot = sum @set;

# Ideal solution: $tot/2 in each subset.
my $target = $tot / 2;
my $mindist;
my @subset;

# Extract nCr with r half of n and look for $target (or min
# dist from it) in the sum.
my $combo = Math::Combinatorics->new (
	count => int (@set / 2),
	data  => [@set]
);
while (my @c = $combo->next_combination) {
	my $sum  = sum @c;
	my $dist = abs ($target - $sum);
	unless (defined ($mindist) && $dist > $mindist) {
		$mindist = $dist;
		@subset  = @c;
	}
	last if $dist < 1;
}

@subset = sort { $a <=> $b } @subset;
my $diff = Array::Diff->diff (\@set, \@subset);
my @othersubset = @{$diff->deleted};

print "Subset 1 = (@subset)\nSubset 2 = (@othersubset)\n";
