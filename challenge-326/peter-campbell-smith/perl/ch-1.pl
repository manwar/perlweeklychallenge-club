#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-16
use utf8;     # Week 326 - task 1 - Day of the year
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

day_of_the_year('2025-02-02');
day_of_the_year('2025-04-10');
day_of_the_year('2025-09-07');
day_of_the_year('1900-12-31');  # not a leap year
day_of_the_year('2000-12-31');  # was a leap year
day_of_the_year('1819-05-24');  # Queeen Victoria born
day_of_the_year('2047-11-09');  # my 100th birthday
day_of_the_year('1752-12-31');
day_of_the_year('0001-01-01');
day_of_the_year('9999-12-31');

# today
my @t = localtime;
day_of_the_year(sprintf('%04d-%02d-%02d', $t[5] + 1900, $t[4] + 1, $t[3]));

sub day_of_the_year {
	
	my($y, $m, $d, $day_of_year, @days_in_month);
	
	# initialise
	say qq[\nInput:    \$date = '$_[0]'];
	($y, $m, $d) = $_[0] =~ m|(\d\d\d\d)\-(\d\d)\-(\d\d)|;
	
	# method 1 - use a module
	use Date::Calc 'Day_of_Year';
	say qq[Output 1: ] . Day_of_Year($y, $m, $d);
	
	# method 2 - use plain Perl
	@days_in_month = (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	
	# fix February
	$days_in_month[2] ++ if ($y % 4 == 0 and not ($y % 100 == 0 and $y / 400 % 4 == 0));
	
	# days in this month plus total of previous months
	$day_of_year = $d + 0;
	$day_of_year += $days_in_month[$_] for 1 .. $m - 1;
	say qq[Output 2: $day_of_year];
}
