#!/usr/bin/perl

# Peter Campbell Smith - 2022-09-20
# PWC 183 task 2

use v5.28;
use utf8;
use warnings;
use Time::Local qw(timelocal_posix);

# You are given two dates, $date1 and $date2 in the format YYYY-MM-DD. Write a script to find 
# the difference between the given dates in terms on years and days only.

# Blog: https://pjcs-pwc.blogspot.com/2022/09/unique-arrays-and-differing-dates.html

my (@tests, $test, $date1, $date2, $days, $years, $anniversary, $month_day);

@tests =  (
	['2019-02-10', '2022-11-01'],
	['2020-09-15', '2022-03-29'],
	['2019-12-31', '2020-01-01'],
	['2019-12-01', '2019-12-31'],
	['2019-12-31', '2020-12-31'],
	['2019-12-31', '2021-12-31'],
	['2020-09-15', '2021-09-16'],
	['2019-09-15', '2021-09-16'],
	['1926-04-21', '2022-09-08'],
	['2022-09-20', '2022-09-19']);

# loop over input tests
for $test (@tests) {
	($date1, $date2) = @$test;
	
	# output input
	say qq[\nInput:  \$date1 = $date1\n        \$date2 = $date2];
	if ($date2 lt $date1) {
		say qq[\$date2 = $date2 precedes \$date1 = $date1];
		next;
	}
	
	# initialise
	$years = 0;
	$days = 0;
	$anniversary = substr($date1, 5, 5);   # month and day of date1
	
	# increment date1 until it reaches date2
	while ($date1 lt $date2) {
		$date1 = date_add($date1, 1);
		$month_day = substr($date1, 5, 5);
		
		# if month and day match date1, increment years and reset days to 0
		if ($month_day eq $anniversary) {
			$years ++;
			$days = 0;
			
		# otherwise just increment days
		} else {
			$days ++;
		}
	}
	
	# format per Mohammad
	say qq[Output: ] . ($years == 0 ? '' : ($years == 1 ? '1 year ' : qq[$years years ])) .
		($days == 0 ? '' : ($days == 1 ? '1 day' : qq[$days days]))
}
	
sub date_add {  #  (date, days)

	# adds days to date
	my (@tt);
	if ($_[0] =~ m|^(....)-(..)-(..)|) {
		@tt = localtime(timelocal_posix(0, 0, 12, $3, $2 - 1, $1 - 1900) + $_[1] * 86400);
		return sprintf('%04d-%02d-%02d', $tt[5] + 1900, $tt[4] + 1, $tt[3]);
	} else {
		return 0;
	}
}
	
