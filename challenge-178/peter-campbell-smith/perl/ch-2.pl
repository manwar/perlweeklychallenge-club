#!/usr/bin/perl

# Peter Campbell Smith - 2022-08-15
# PWC 178 task 2

use v5.28;
use utf8;
use warnings;
use Time::Local 'timelocal_posix';
# use Date::Format;

# Write a script to find the time that occurs $duration business hours after 
# $timestamp. For the sake of this task, let us assume the working hours is 9am to 6pm, Monday to Friday.

# Blog: 

my (@tests, $test, $start, $duration, $d, $m, $y, $h, $i, $s, $date, $day_of_week, 
	$whole_weeks, $whole_days, $end, @t);
			 
@tests = (	['2022-08-17 15:00:00', 93], 
			['2022-08-17 15:00:00', 45 * 52 + 9], # a year
			['2023-01-02 09:00:00', 999999],
			['2022-08-22 18:00:00', 0],
			['2022-08-17 12:00:00', 1.56]);

for $test (@tests) {
	$start = $test->[0];
	$duration = $test->[1];   # hours
	
	$start =~ m|(....).(..).(..).(..).(..).(..)|;
	($y, $m, $d, $h, $i, $s) = ($1, $2, $3, $4, $5, $6);
	
	# start must be in working hours
	@t = localtime(timelocal_posix($s, $i, $h, $d, $m - 1, $y - 1900));
	if ($t[6] == 0 or $t[6] == 6 or $h < 9 or ($h >= 18 and $h.$i.$s ne '180000')) {
		say qq[\ntimestamp $start not within working hours];
		next;
	}
	
	# move back to 9am on the starting day
	$date = substr($start, 0, 10);
	$duration += $h - 9 - $i / 60 - $s  / 3600 ;   # revised duration	
	
	# move back to preceding Monday 9am
	@t = localtime(timelocal_posix($s, $i, $h, $d, $m - 1, $y - 1900));
	$day_of_week = $t[6];   # 0 = Sunday
	$date = date10_add($start, 1 - $day_of_week);
	$duration += ($day_of_week - 1) * 9;
		
	# move forward complete weeks
	$whole_weeks = int($duration / 45);	
	$date = date10_add($date, 7 * $whole_weeks);
	$duration -= $whole_weeks * 45;
	
	# and whole days
	$whole_days = int($duration / 9);
	$date = date10_add($date, $whole_days);
	$duration -= $whole_days * 9;

	# and the time of day
	$h = 9 + int($duration);
	$duration -= int($duration);
	$duration *= 3600;  # seconds
	$i = int($duration / 60);
	$s = $duration - $i * 60;
	
	$end = sprintf('%s %02d:%02d:%02d', $date, $h, $i, $s);
	say qq[\ntimestamp = $start\nduration  = $test->[1]\nend       = $end]; 	
}

sub date10_add {  #  (date10a, days) -- returns date10 which is days after date10a

	my (@t);
	if ($_[0] =~ m|^(....)-(..)-(..)|) {
		@t = localtime(timelocal_posix(0, 0, 12, $3, $2 - 1, $1 - 1900) + $_[1] * 86400);
		return sprintf('%04d-%02d-%02d', $t[5] + 1900, $t[4] + 1, $t[3]);
	} else {
		return 0;
	}
}
	
	