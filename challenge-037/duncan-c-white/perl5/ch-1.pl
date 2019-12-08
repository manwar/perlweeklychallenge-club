#!/usr/bin/perl
#
# Challenge 1: "Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.
# Jan 2019: 23 weekdays
# Feb 2019: 20 weekdays
# Mar 2019: 21 weekdays
# Apr 2019: 22 weekdays
# May 2019: 23 weekdays
# Jun 2019: 20 weekdays
# Jul 2019: 23 weekdays
# Aug 2019: 22 weekdays
# Sep 2019: 21 weekdays
# Oct 2019: 23 weekdays
# Nov 2019: 21 weekdays
# Dec 2019: 22 weekdays
# "
# 
# My notes: sounds rather straightforward, even without date manipulation
# modules.  This second version does it ourselves from scratch.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;


die "Usage: ch-1.pl [YEAR]\n" if @ARGV>1;

my @month = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);


#
# my $isleap = isleapyear( $y );
#	Return 1 if year $y is a leap year; 0 if not.
#
fun isleapyear( $y )
{
	return 0 unless $y % 4 == 0;
	return 1 unless $y % 100 == 0;
	return 0 unless $y % 400 == 0;
	return 1;
}


#
# my $dow = dayofweek1stjanyear( $y );
#	Find the day-of-the-week
#	(0=Monday, 1=Tuesday.. 4=Friday, 5=Saturday, 6=Sunday)
#	of 1st Jan $y (only valid for y>=1900).  Return it.
#
fun dayofweek1stjanyear( $y )
{
	# first, calculate dow in range 0..6
	my $dow = 0;	# 1st Jan 1900 was a Monday..
	foreach my $y (1900..$y-1)
	{
		my $days = isleapyear($y) ? 2 : 1;
		#print "$y: advance $days days\n";
		$dow += $days;
		$dow %= 7;
	}
	return $dow;
}


#
# my $daysinmonth = daysinmonth( $m, $isleap );
#	Return the number of days in month $m (0..11), adjusting
#	number of days in February is $isleap is true.
#
fun daysinmonth( $m, $isleap )
{
	my @d = (31,28,31,30,31,30,31,31,30,31,30,31);
	$d[1]=29  if $isleap;
	return $d[$m];
}


my $y = shift // 2019;
my $isleap = isleapyear( $y );
my $dow = dayofweek1stjanyear( $y );
#print "1st Jan $y is day-of-week $dow\n";

foreach my $m (0..11)
{
	my $daysinmonth = daysinmonth( $m, $isleap );
	#print $month[$m], " $y: had $daysinmonth days\n";
	my $weekdays = 0;
	foreach my $d (1..$daysinmonth)
	{
		$weekdays++ if $dow < 5;
		$dow++;
		$dow %= 7;
	}
	print $month[$m], " $y: $weekdays weekdays\n";
}
