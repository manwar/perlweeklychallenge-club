#!/usr/bin/perl
# 
# TASK #1 - Long Year
# 
# Write a script to find all the years between 1900 and 2100 which is a Long Year.
# 
#     A year is Long if it has 53 weeks.
# 
# For more information about Long Year, please refer to
# 
# https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
# 
# Expected Output
# 
# 1903, 1908, 1914, 1920, 1925,
# 1931, 1936, 1942, 1948, 1953,
# 1959, 1964, 1970, 1976, 1981,
# 1987, 1992, 1998, 2004, 2009,
# 2015, 2020, 2026, 2032, 2037,
# 2043, 2048, 2054, 2060, 2065,
# 2071, 2076, 2082, 2088, 2093,
# 2099
# 
# MY NOTES: Pretty easy.  Especially using the p(year) and weeks(year) functions given,
# won't even need a date manipulation module..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;


my $debug=0;
die "Usage: long-year\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==0;

#
# my $dow = dow_31stdec( $year );
#	Return the Dow (0..6, 0 is Sunday, 6 is Saturday) of 31st Dec in $year.
#	Wikipedia's P() function:
#
fun dow_31stdec( $year )
{
	my $x = $year + int($year/4) - int($year/100) + int($year/400);
	return $x % 7;
}


#
# my $weeks = weeksinyear( $year );
#	How many weeks does year $year have?  52 or 53..
#
fun weeksinyear( $year )
{
	my $result = 52;
	$result++ if dow_31stdec( $year ) == 4	 # current year ends on Thursday
		  || dow_31stdec( $year-1) == 3; # previous year ends on Wednesday
	return $result;
}

#my @dow = qw(Sun Mon Tue Wed Thu Fri Sat);

my @result;
foreach my $y (1900..2100)
{
	#my $dow = dow_31stdec( $y );
	#say "31st dec $y is a $dow[$dow]";
	my $weeks = weeksinyear( $y );
	#say "$y has $weeks weeks";
	next if $weeks == 52;
	push @result, $y;
}

while( @result > 4 )
{
	say join( ', ', @result[0..4] ).',';
	splice( @result, 0, 5 );
}
say join( ', ', @result );
