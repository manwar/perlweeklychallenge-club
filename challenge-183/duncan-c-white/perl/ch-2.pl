#!/usr/bin/perl
# 
# Task 2: Date Difference
# 
# You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.
# Write a script to find the difference between the given dates in terms
# of years and days only.
# 
# Example 1
# 
# Input: $date1 = '2019-02-10'
#        $date2 = '2022-11-01'
# Output: 3 years 264 days
# 
# Example 2
# 
# Input: $date1 = '2020-09-15'
#        $date2 = '2022-03-29'
# Output: 1 year 195 days
# 
# Example 3
# 
# Input: $date1 = '2019-12-31'
#        $date2 = '2020-01-01'
# Output: 1 day
# 
# Example 4
# 
# Input: $date1 = '2019-12-01'
#        $date2 = '2019-12-31'
# Output: 30 days
# 
# Example 5
# 
# Input: $date1 = '2019-12-31'
#        $date2 = '2020-12-31'
# Output: 1 year
# 
# Example 6
# 
# Input: $date1 = '2019-12-31'
#        $date2 = '2021-12-31'
# Output: 2 years
# 
# Example 7
# 
# Input: $date1 = '2020-09-15'
#        $date2 = '2021-09-16'
# Output: 1 year 1 day
# 
# Example 8
# 
# Input: $date1 = '2019-09-15'
#        $date2 = '2021-09-16'
# Output: 2 years 1 day
# 
# MY NOTES: Should be a simple task for Date::Simple or Date::Manup.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Date::Simple qw(date);

my $debug=0;
die "Usage: date-diff [--debug] ISODATE1 ISODATE2\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my $date1 = date(shift);
my $date2 = date(shift);
if( $date1 > $date2 )
{
	($date1,$date2) = ($date2,$date1);      # swap dates
}

# first, find number of whole years difference
# by finding the "date 1 year ahead of date1"
my $oneyearahead = date($date1->year+1, $date1->month, $date1->day );
say "debug: oneyearahead=$oneyearahead" if $debug;

my $years = 0;
while( $date2 >= $oneyearahead )
{
	$years++;
	$date2 = date($date2->year-1, $date2->month, $date2->day );
	say "debug: years=$years, date1=$date1, date2=$date2" if $debug;
}

# second, find number of remaining days difference
my $days = $date2 - $date1;

my $outstr = "";
$outstr = "$years year " if $years==1;
$outstr = "$years years " if $years>1;
$outstr .= "$days day" if $days>0 || $years==0;
$outstr .= "s" if $days>1;
say $outstr;
