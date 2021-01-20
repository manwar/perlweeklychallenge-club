#!/usr/bin/env perl

# Challenge 019
#
# Task #1
# Write a script to display months from the year 1900 to 2019 where you find 
# 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

use strict;
use warnings;
use 5.030;
use Date::Calc qw( Nth_Weekday_of_Month_Year );
use constant {
	Friday => 5,
	Saturday => 6,
	Sunday => 7 
};

for my $year (1900 .. 2019) {
	for my $month (1 .. 12) {
		say sprintf("%04d-%02d", $year, $month) if five_weekends($year, $month);
	}
}


sub five_weekends {
	my($year, $month) = @_;
	return unless Nth_Weekday_of_Month_Year($year, $month, Friday, 5);
	return unless Nth_Weekday_of_Month_Year($year, $month, Saturday, 5);
	return unless Nth_Weekday_of_Month_Year($year, $month, Sunday, 5);
	return 1;
}
