#!/usr/bin/perl
# 
# Task 1: Last Sunday
# 
# Write a script to list Last Sunday of every month in the given year.
# 
# For example, for year 2022, we should get the following:
# 
# 2022-01-30
# 2022-02-27
# 2022-03-27
# 2022-04-24
# 2022-05-29
# 2022-06-26
# 2022-07-31
# 2022-08-28
# 2022-09-25
# 2022-10-30
# 2022-11-27
# 2022-12-25
# 
# MY NOTES: ok, sounds pretty easy: basically, start on the 1st of the
# month, and walk forwards hitting the date when we hit a Sunday.  The
# hardest part is, as always, choosing which date manipulation module to use.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Date::Simple ('ymd');


my $debug=0;
die "Usage: last-sunday-in-every-month [--debug] YYYY\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $y = shift;

foreach my $m (1..12)
{
	my $sunday;
	for( my $d = ymd($y, $m, 1); $d->month == $m; $d++ )
	{
		$sunday = $d if $d->day_of_week() == 0;
	}
	say $sunday;
}
