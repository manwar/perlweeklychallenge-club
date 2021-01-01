#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9301.pl
#
#        USAGE: ./9301.pl X Y X Y [ X Y ] ....
#
#  DESCRIPTION: Find the most points intersected by a single straight line
#
# REQUIREMENTS: List::Util (in core)
#        NOTES: Assumes integer co-ordinates only
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/12/20
#===============================================================================

use strict;
use warnings;
use List::Util qw/max pairs/;

my @points = pairs join (' ', @ARGV) =~ /[0-9-]+/g;

my %lines;

for my $i (0 .. $#points) {
	for my $j ($i + 1 .. $#points) {
		my ($grad, $offset) = linear (@points[$i, $j]);
		$lines{"$grad,$offset"}{$_} = 1 for ($i, $j);
	}
}

# Find the greatest number of points on all these lines
my $max = max map { scalar values %$_ } values %lines;

# Result
print "$max\n";

sub linear {
	my @p = @_;

	# solve y = mx + c for m and c given 2 (x,y) pairs 
	my ($m, $c);
	if ($p[0]->[0] == $p[1]->[0]) {
		# Vertical line special case: use x = c as line
		return ('NaN', $p[0]->[0]);
	}
	$m = ($p[0]->[1] - $p[1]->[1]) / ($p[0]->[0] - $p[1]->[0]);
	$c = $p[0]->[1] - $m * $p[0]->[0];
	return ($m, $c);
}
