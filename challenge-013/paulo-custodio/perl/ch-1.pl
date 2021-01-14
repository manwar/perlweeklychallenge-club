#!/usr/bin/env perl

# Challenge 013
#
# Challenge #1
# Write a script to print the date of last Friday of every month of a given year.
# For example, if the given year is 2019 then it should print the following:
# 
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

use strict;
use warnings;
use 5.030;
use Date::Calc 'Nth_Weekday_of_Month_Year';

our $Friday = 5;

sub last_friday {
	my($year,$month) = @_;
	for my $n (reverse 1..5) {
		if (my($y,$m,$d) = Nth_Weekday_of_Month_Year($year,$month,$Friday,$n)) {
			return ($y,$m,$d);
		}
	}
}

my $year = shift || 2021;
for my $month (1..12) {
	my($y,$m,$d) = last_friday($year,$month);
	printf("%04d/%02d/%02d\n", $y,$m,$d);
}
