#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11702.pl
#
#        USAGE: ./11702.pl N
#
#  DESCRIPTION: For an equilateral triangle of sides N units, find all
#  possible paths from the apex to lower right vertex travelling
#  down-left, down-right and/or flat-right only.
#
#        NOTES: A size of 10 takes under 2s on my machine. YMMV.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 14/06/21
#===============================================================================

use strict;
use warnings;

my ($n) = (shift =~ /([0-9]+)/);
die "Bad argument - must be a small natural number.\n" unless $n && $n < 21;

my %subs; # memoize the end paths
my @paths = walk ($n, 0);
print "@paths\n";

# The co-ordinate system used here is that the first dimension is how
# far from the floor of the triangle we are (think y axis), the second
# is how far from the right slope we are (negative x axis but angled).
# Bottom-right vertex is (0,0), bottom-left is (0, $n), top is ($n, 0).
# Just pass the co-ordinates to walk() and you'll get back an array of
# all the possible paths from there to (0,0).

sub walk {
	my ($l, $x) = @_;
	return @{$subs{$l}{$x}} if exists $subs{$l}{$x};

	my @paths;
	if ($l) {
		# Not at the bottom yet so can go left or right
		push @paths, map { 'L' . $_ } walk ($l - 1, $x + 1);
		push @paths, map { 'R' . $_ } walk ($l - 1, $x);
	}
	if ($x) {
		# Not at right edge yet, so can go horizontally right
		push @paths, map { 'H' . $_ } walk ($l, $x - 1);
	}

	# If at the bottom right already, no paths from here
	@paths = ('') unless $l || $x;

	$subs{$l}{$x} = \@paths;
	return @paths;
}
