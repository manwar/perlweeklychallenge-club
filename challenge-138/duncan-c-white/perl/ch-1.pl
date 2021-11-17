#!/usr/bin/perl
# 
# TASK #1 - Workdays
# 
# You are given a year, $year in 4-digits form.
# 
# Write a script to calculate the total number of workdays in the given year.
# For the task, we consider, Monday - Friday as workdays.
# 
# Example 1
# 
# 	Input: $year = 2021
# 	Output: 261
# 
# Example 2
# 
# 	Input: $year = 2020
# 	Output: 262
# 
# MY NOTES: Pretty easy.  Essentially: iterate over all days in $year, inc
# count if day_of_week(that day) is a week day (Mon..Fri).  Date::Simple
# looks like it can do everything we need.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Date::Simple (':all');
#use Data::Dumper;


my $debug=0;
die "Usage: work-days Year\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $year = shift;

my $weekdays = 0;
for( my $day = date("$year-01-01"); $day->year == $year; $day++ )
{
	my $dow = $day->day_of_week;
	$weekdays++ if $dow >= 1 && $dow <= 5;
}
say $weekdays;
