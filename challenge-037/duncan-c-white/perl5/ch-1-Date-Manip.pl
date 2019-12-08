#!/usr/bin/perl
#
# Challenge 1: "Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.
# Jan: 23 days
# Feb: 20 days
# Mar: 21 days
# Apr: 22 days
# May: 23 days
# Jun: 20 days
# Jul: 23 days
# Aug: 22 days
# Sep: 21 days
# Oct: 23 days
# Nov: 21 days
# Dec: 22 days
# "
# 
# My notes: sounds rather straightforward, with or without date manipulation
# modules.  This first version uses Date::Manip's Date_DaysInMonth(m,y) and
# Date_DayOfWeek(m,d,y) functions.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use Date::Manip;


die "Usage: ch-1.pl [YEAR]\n" if @ARGV>1;

my @month = qw(X Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);


#
# my $n = countweekdays( $y, $m );
#	Find how many week days (Monday..Friday) there are in month $month
#	(1..12) in year $y.
#
fun countweekdays( $year, $month )
{
	my $n = 0;
	my $ndays = Date_DaysInMonth( $month,$year );
	foreach my $dayno (1..$ndays)
	{
		my $day = Date_DayOfWeek( $month, $dayno, $year );
		$n++ if $day < 6;
	}
	return $n;
}


my $y = shift // 2019;
foreach my $m (1..12)
{
	my $n = countweekdays( $y, $m );
	print $month[$m], " $y: $n weekdays\n";
}
