#!/usr/bin/env perl

# You are given a year number in the range 1753 to 9999.
# 
# Write a script to find out how many dates in the year are Friday 13th, assume
# that the current Gregorian calendar applies.  Example
# 
# Input: $year = 2023 Output: 2
# 
# Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and
# 13th Oct.

use strict;
use warnings;
use Date::Calc qw/Day_of_Week/;
use Test::More;
use Data::Dumper;

my $cases = [
	1753,
	2023,
	9999,
];

sub friday13th
{
    my $y = shift;
	my $c = 0;
	for my $m (1..12) {
		my $dow = Day_of_Week($y, $m, 13);
		++$c if $dow == 5; # Friday
	}
	return $c;
}

is(friday13th($cases->[0]),    2, 'year 1753');
is(friday13th($cases->[1]),    2, 'year 2023');
is(friday13th($cases->[2]),    1, 'year 9999');
done_testing();

exit 0;
