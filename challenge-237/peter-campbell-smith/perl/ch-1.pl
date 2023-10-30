#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-02
use utf8;     # Week 237 task 1 - Seize the day
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

seize_the_day(2024, 4, 3, 2);
seize_the_day(2025, 10, 2, 4);
seize_the_day(2026, 8, 5, 3);
seize_the_day(1947, 11, 2, 7);
seize_the_day(2024, 2, 5, 4);
seize_the_day(9999, 12, 5, 5);
seize_the_day(1753, 1, 1, 1);
seize_the_day(2023, 10, 2, 1);

sub seize_the_day {
	
	my ($year, $month, $week, $day, @days, @months, @days_in_month, @suffix,
		$dow, $dom, $result);
	
	($year, $month, $week, $day) = @_;
	
	# sanity check
	say qq[\nInput:  \$year = $year, \$month = $month, \$week = $week, \$day = $day];
	if ($year < 1753 or $month < 1 or $month > 12 or $week < 0 or $day < 1 or $day > 7) {
		say qq[Output: bad data];
		return;
	}
	
	# initialise
	@days = qw[Sun Mon Tues Wednes Thurs Fri Satur];
	@months = qw[x January February March April May June July August September October November December];
	@days_in_month = (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	$days_in_month[2] += 1 if is_leap($year);
	push @suffix, 'th' for (0 .. 31);
	$suffix[$1] = $2 while '1st 2nd 3rd 21st 22nd 23rd 31st' =~ m|(\d+)([a-z]{2})|g;
	$day = $day % 7;
	
	# get day of the week for 1 Jan $year
	$dow = -1;
	$dow += is_leap($_- 1) ? 2 : 1 for 1753 .. $year;
	
	# get day of week for 1 $month $year
	if ($month > 1) {
		$dow += $days_in_month[$_] for (0 .. $month - 1);
	}
	$dow = $dow % 7;
	
	# get day of month for first $day in the month
	$dom = ($day - $dow + 7) % 7 + 1;
	
	# get day of month for $week-th $day in the month
	$dom += ($week - 1) * 7;
	
	# does it exist?
	if ($dom > $days_in_month[$month]) {
		say qq[Output: There is no $week$suffix[$week] $days[$day]day in $months[$month] $year];
	} else {
		say qq[Output: The $week$suffix[$week] $days[$day]day of $months[$month] $year is the $dom$suffix[$dom]];
	}
}

sub is_leap {  # returns 1 for leap year, 0 for non-leap
	
	                     # non-century year   :  century year 
	return ($_[0] % 100 ? ($_[0] % 4 ? 0 : 1) : ($_[0] % 400 ? 0 : 1));
}
