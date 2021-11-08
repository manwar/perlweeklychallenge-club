#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12302.pl
#
#        USAGE: ./12302.pl X,Y X,Y X,Y X,Y
#
#  DESCRIPTION: Output 1 if the 4 co-ordinate pairs are the corners of a
#               square, 0 otherwise.
#
#        NOTES: We do calculate each length twice but for such a small
#               number of points I think avoiding that does not warrant the
#               additional complexity.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 26/07/21
#===============================================================================

use strict;
use warnings;

my @points = get_args ();

# Every line is either a side or a diagonal, so each point must have 
# length L to 2 other points and root 2 L to the third.
# Use square lengths throughout so we don't keep calling sqrt all the time.
my $side;
for my $pointidx (0 .. 3) {
	my @lens;
	for my $otherend (0 .. 3) {
		push @lens, line_sqlen ($points[$pointidx], $points[$otherend])
			unless $pointidx == $otherend;
	}
	@lens = sort { $a <=> $b } @lens;
	$side //= $lens[0];
	unless (
		$lens[0] == $side &&
		$lens[1] == $side &&
		$lens[2] == 2 * $side
	) {
		print "0\n";
		exit;
	}
}
print "1\n";

sub line_sqlen {
	# Given 2 points, return the square of the distance between them
	my @p = @_;
	return (
		($p[1]->[0] - $p[0]->[0]) ** 2 +
		($p[1]->[1] - $p[0]->[1]) ** 2
	);
}

sub get_args {
	my $usage = "  Usage: $0 x1,y1 x2,y2 x3,y3 x4,y4\n";
	die "Need 4 co-ordinate pairs\n$usage" unless 4 == @ARGV;
	my @in;
	for (@ARGV) {
		my ($x, $y) = /^([-0-9.]+),([-0-9.]+)$/;
		die "Argument '$_' does not look like X,Y\n$usage"
			unless defined ($x) && defined ($y);
		push @in, [$x, $y];
	}
	return @in;
}
