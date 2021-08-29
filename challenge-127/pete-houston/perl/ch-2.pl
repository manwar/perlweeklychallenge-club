#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12702.pl
#
#        USAGE: ./12702.pl A,B C,D [ E,F ... ]
#
#  DESCRIPTION: Given pairs of integers treat each as an interval and
#               report any which conflict with previous pairs.
#               The pairs may each be comma-separated but really anything
#               other than digits and hyphens will do to separate them
#
#        NOTES: We assume that each supplied number is an integer.
#               Further, we assume that "conflict" means that if N is
#               the upper bound of one interval and the lower bound of
#               another then that is a conflict.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/08/21
#===============================================================================

use strict;
use warnings;

my (@ints, @conflicts);

while (my $pair = shift) {
	# Extract 2 integers from each argument
	# Don't assume the lower limit comes first
	my ($lower, $upper) = sort { $a <=> $b } $pair =~ /(-?[0-9]+)/g;

	# Validate
	die "$pair is not an interval"
		unless defined ($lower) && defined ($upper);

	# Compare to previous intervals
	for my $int (@ints) {
		next if $lower > $int->[1] || $upper < $int->[0];
		push @conflicts, [$lower, $upper];
		last;
	}

	# Add to the list
	push @ints, [$lower, $upper];
}

print '[ ', join (', ', map { "($_->[0],$_->[1])" } @conflicts), " ]\n";
