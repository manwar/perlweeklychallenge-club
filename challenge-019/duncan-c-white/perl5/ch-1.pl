#!/usr/bin/perl
#
# Challenge 1: "Write a script to display months from the year 1900 to 2019
# where you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday."
# 
# My notes:
# 
# Clearly defined, although Friday isn't normally considered part of the
# weekend is it?  Anyway, it's clear here that Friday - Sunday is the weekend
# for the purposes of this question.  Date::Manip can do this easily enough.
# 

use strict;
use warnings;
use Function::Parameters;
use List::Util qw(min);
use Date::Manip;
use Data::Dumper;

die "Usage: ch-1.pl [STARTYEAR [ENDYEAR]]\n" if @ARGV>2;
my $startyear = shift // 1900;
my $endyear = shift // 2019;

#
# my $n = threedayweekends( $year, $month );
#	Find how many three day weekends (Friday, Saturday and Monday)
#	there are in month $month (1..12) in year $year.
#
fun threedayweekends( $year, $month )
{
	my $nfri = 0;
	my $nsat = 0;
	my $nsun = 0;
	my $ndays = Date_DaysInMonth( $month,$year );
	foreach my $dayno (1..$ndays)
	{
		my $day = Date_DayOfWeek( $month, $dayno, $year );
		$nfri++ if $day == 5;
		$nsat++ if $day == 6;
		$nsun++ if $day == 7;
	}
	return min( $nfri, $nsat, $nsun );
}


foreach my $y ($startyear..$endyear)
{
	foreach my $m (1..12)
	{
		my $n = threedayweekends( $y, $m );
		printf "%02d/$y $n three day weekends\n", $m if $n==5;
	}
}
