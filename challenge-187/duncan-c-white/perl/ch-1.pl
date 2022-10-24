#!/usr/bin/perl
# 
# Task 1: Days Together
# 
# Two friends, Foo and Bar gone on holidays seperately to the same city. You
# are given their schedule i.e. start date and end date.
# 
# To keep the task simple, the date is in the form DD-MM and all dates
# belong to the same calendar year i.e. between 01-01 and 31-12. Also the
# year is non-leap year and both dates are inclusive.
# 
# Write a script to find out for the given schedule, how many days they
# spent together in the city, if at all.
# 
# Example 1
# 
# Input: Foo => SD: '12-01' ED: '20-01'
#        Bar => SD: '15-01' ED: '18-01'
# 
# Output: 4 days
# 
# Example 2
# 
# Input: Foo => SD: '02-03' ED: '12-03'
#        Bar => SD: '13-03' ED: '14-03'
# 
# Output: 0 day
# 
# Example 3
# 
# Input: Foo => SD: '02-03' ED: '12-03'
#        Bar => SD: '11-03' ED: '15-03'
# 
# Output: 2 days
# 
# Example 4
# 
# Input: Foo => SD: '30-03' ED: '05-04'
#        Bar => SD: '28-03' ED: '02-04'
# 
# Output: 4 days
# 
# MY NOTES: pretty easy.  Let's do it by hand (no Date modules to inc-date)
# given all the constraints, same year, non-leap year.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(min max);
use Function::Parameters;


my $debug=0;
die "Usage: overlapping-days [--debug] dd-mm-sd1 dd-mm-ed1 dd-mm-sd2 dd-mm-ed2\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==4;


my @dim = ( -1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );

=pod

=head2 my $day_in_year = yearday( $ddmm );

Check whether $ddmm is a valid date of format dd-mm where dd is 1..31
and mm is 1..12 (and dd <= days_in_month(mm)), returning the day number
in the year if it is, or -1 if it is invalid.

=cut
fun yearday( $ddmm )
{
	return -1 unless $ddmm =~ /^(\d\d?)-(\d\d?)$/;
	my( $d, $m ) = ( $1, $2 );
	return -1 if $m < 1 || $m > 12;
	return -1 if $d < 1 || $d > $dim[$m];
	my $dayno = 0;
	for( my $i=1; $i<$m; $i++ )
	{
		$dayno += $dim[$i];
	}
	$dayno += $d;
	return $dayno;
}


my( $sd1, $ed1, $sd2, $ed2 ) = @ARGV;
my $sd1d = yearday( $sd1 ); # days since start of year for sd1
die "Bad dd-mm-sd1 ($sd1)\n" if $sd1d<1;
my $ed1d = yearday( $ed1 );
die "Bad dd-mm-ed1 ($ed1)\n" if $ed1d<1;
my $sd2d = yearday( $sd2 );
die "Bad dd-mm-sd2 ($sd2)\n" if $sd2d<1;
my $ed2d = yearday( $ed2 );
die "Bad dd-mm-ed2 ($ed2)\n" if $ed2d<1;

say "sd1:$sd1d, ed1:$ed1d, sd2:$sd2d, ed2:$ed2d";


=pod

=head2 my $noverlap = overlapdays( $sd1d, $ed1d, $sd2d, $ed2d );

Find out the number of overlapping days between the two ranges
of dates, as the task describes.  Each date is represented by a logical
day-number-in-the-year.  Return 0 if no overlap.

=cut
fun overlapdays( $sd1d, $ed1d, $sd2d, $ed2d )
{
	# none if one range finishes before the other
	return 0 if $ed1d < $sd2d || $ed2d < $sd1d;

	my $csd = max($sd1d,$sd2d); # common start date
	my $ced = min($ed1d,$ed2d); # common end date

	return 1+$ced-$csd;
}


my $noverlap = overlapdays( $sd1d, $ed1d, $sd2d, $ed2d );
say "$noverlap days";
