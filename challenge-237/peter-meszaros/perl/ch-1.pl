#!/usr/bin/env perl
#
# Given a year, a month, a weekday of month, and a day of week (1 (Mon) .. 7
# (Sun)), print the day.
# 
# Example 1
# 
# Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
# Output: 16
# 
# The 3rd Tue of Apr 2024 is the 16th
# 
# Example 2
# 
# Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
# Output: 9
# 
# The 2nd Thu of Oct 2025 is the 9th
# 
# Example 3
# 
# Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
# Output: 0
# 
# There isn't a 5th Wed in Aug 2026
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Date::Calc qw/Nth_Weekday_of_Month_Year/;

my $cases = [
	# Year, Month, Weekday of month, day of week
	[ 2024,  4, 3,  2],
	[ 2025, 10, 2,  4],
	[ 2026,  8, 5,  3],
];

sub seize_the_day
{
	my $l = shift;

	my (undef, undef, $day) =
		Nth_Weekday_of_Month_Year($l->[0],
                                  $l->[1],
                                  $l->[3],
                                  $l->[2]);

    return $day // 0;
}

is(seize_the_day($cases->[0]), 16, '[ 2024,  4, 3,  2]');
is(seize_the_day($cases->[1]),  9, '[ 2025, 10, 2,  4]');
is(seize_the_day($cases->[2]),  0, '[ 2026,  8, 5,  3]');
done_testing();

exit 0;


