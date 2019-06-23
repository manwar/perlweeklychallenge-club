#!/usr/bin/perl

# Challenge 1: "Write a script to print the date of last Friday of every
# month of a given year. For example, if the given year is 2019 then it
# should print the following:
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
# 
# 
# My notes:
# 
# Date::Manip should be able to do that easily enough.

use strict;
use warnings;
use Function::Parameters;
use Date::Manip;
use Data::Dumper;

die "Usage: ch-1.pl YEAR\n" unless @ARGV==1;
my $year = shift;

#
# my $dayno = findlasstfriday( $year, $month );
#	Find the day number (1..31) of the last Friday in
#	month $month (1..12) in year $year.
#
fun findlasstfriday( $year, $month )
{
	my $ndays = Date_DaysInMonth $month,$year;
	my $lastfriday = -1;
	foreach my $dayno (21..$ndays)
	{
		my $day = Date_DayOfWeek( $month, $dayno, $year );
		$lastfriday = $dayno if $day == 5;
	}
	return $lastfriday;
}


foreach my $m (1..12)
{
	my $dayno = findlasstfriday( $year, $m );
	printf "$year/%02d/$dayno\n", $m;
}
