#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-19
# PWC 187 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# Two friends, Foo and Bar have been on holiday separately to the same city. You are given their schedule 
# ie start date and end date. The date is in the form DD-MM and all dates belong to the same calendar year 
# ie between 01-01 and 31-12. Also the year is non-leap year and both dates are inclusive.
# Write a script to find out how many days they spent together in the city, if at all.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/foo-meets-bar-and-wizardly-trio.html

my (@days_in_month, @tests, $test, $j, $day, $month, @day_of_year, 
	$start_together, $end_together, $time_together);

@days_in_month = (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

@tests = ([qw[12-01 20-01 15-01 18-01]], [qw[02-03 12-03 13-03 14-03]], 
		  [qw[02-03 12-03 11-03 15-03]], [qw[30-03 05-04 28-03 02-04]],
	      [qw[01-01 31-12 01-01 31-12]], [qw[01-xx 02-02 03-03 04-04]],
		  [qw[01-01 01-01 01-01 01-01]]);

TEST: for $test (@tests) {
	
	# show input
	say qq[\nInput: Foo => SD: '$test->[0]' ED: '$test->[1]'\n] .
          qq[       Bar => SD: '$test->[2]' ED: '$test->[3]'];
	
	# convert dates to day of year (1 Jan -> 1, 31 Dec -> 365)
	for $j (0 .. 3) {
		if ($test->[$j] =~ m|^(\d\d)\-(\d\d)$|) {
			($day, $month) = ($1, $2);
			$day_of_year[$j] = $day;
			while ($month > 1) {
				$day_of_year[$j] += $days_in_month[$month - 1];
				$month --;
			}
		} else {
			say 'Invalid data';
			next TEST;
		}
	}
	
	# the overlap period is from the later of the starts and the earlier of the ends
	$start_together = $day_of_year[0] > $day_of_year[2] ? $day_of_year[0] : $day_of_year[2];
	$end_together = $day_of_year[1] < $day_of_year[3] ? $day_of_year[1] : $day_of_year[3];
	$time_together = $end_together - $start_together + 1;
	
	# if negative then there is no overlap
	$time_together = 0 if $time_together < 0;
	
	say qq[Output: $time_together day] . ($time_together == 1 ? '' : 's');
}


