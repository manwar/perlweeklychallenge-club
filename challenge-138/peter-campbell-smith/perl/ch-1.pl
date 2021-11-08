#!/usr/bin/perl

# Peter Campbell Smith - 2021-11-08
# PWC 138 task 1

use v5.20;
use warnings;
use strict;

# You are given a year in 4-digits form.
# Write a script to calculate the total number of workdays in the given year.
# For the task, we consider, Monday - Friday as workdays.

# Discussion: A non-leap year contains 52 weeks and one day (52 * 7 + 1 = 365).
# 52 weeks between 1 January and 30 December will contain 52 * 5 = 260 working days.
# If 31 December is a working day then the year will contain 261 working days,
# and if it isn't, then the year will contain just 260.
#
# A leap year contains 52 weeks and 2 days, so similarly the number of working days
# in the year is 260 plus 1 if 30 December is a working day and plus another
# 1 if 31 December is a working day.

my ($year, @years, $working_days);

use Time::Local;

@years = (2010 .. 2030);

for $year (@years) {
	$working_days = 5 * 52;
	$working_days++ if is_working_day($year, 12, 31);
	$working_days++ if (is_leap($year) and is_working_day($year, 12, 30)); 
	say qq[Input: \$year = $year\nOutput: $working_days\n];
}

sub is_working_day {  # ($year, $month, $day)

	# returns 1 if date is a working day, else returns 0
	#                           s  m  h   d      m         y
	my @t = localtime(timelocal(0, 0, 12, $_[2], $_[1] - 1, $_[0] - 1900));
	return ($t[6] >= 1 and $t[6] <= 5) ? 1 : 0;
}

sub is_leap {
	
	# returns 1 if given year is leap or 0 if not
	my ($test);
	
	$test = $_[0];
	$test = $test / 100 if $test % 100 == 0;  # xx00 years
	return $test % 4 == 0 ? 1 : 0;
}