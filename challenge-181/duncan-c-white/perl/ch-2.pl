#!/usr/bin/perl
# 
# Task 2: Hot Day
# 
# You are given file with daily temperature record in random order.
# Write a script to find out days hotter than previous day.
# 
# Example
# 
# Input File: (temperature.txt)
# 
# 2022-08-01, 20
# 2022-08-09, 10
# 2022-08-03, 19
# 2022-08-06, 24
# 2022-08-05, 22
# 2022-08-10, 28
# 2022-08-07, 20
# 2022-08-04, 18
# 2022-08-08, 21
# 2022-08-02, 25
# 
# Output:
# 2022-08-02
# 2022-08-05
# 2022-08-06
# 2022-08-08
# 2022-08-10
# 
# MY NOTES: looks pretty easy (easier than first task).  Could parse dates, but
# technically as the dates are all ISO dates, they can be sorted as strings.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: hot-days [--debug] < inputfile\n"
	unless GetOptions( "debug"=>\$debug );

# build @dt, a list of pairs
my @dt;
while( <> )
{
	chomp;
	s/\s+//g;
	my( $date, $temp ) = split( /,/, $_, 2 );
	#say "date=$date, temp=$temp";
	push @dt, [ $date, $temp ];
}

# sort @dt by dates (as strings)
@dt = sort { $a->[0] cmp $b->[0] } @dt;
#die Dumper( \@dt );

# find all dates D for which the temperature on date D is hotter than on D-1.
foreach my $pos (1..$#dt)
{
	my $today = $dt[$pos];
	my $yest = $dt[$pos-1];
	#say "processing date $today->[0], yest $yest->[0], today temp $today->[1], yest temp $yest->[1]";
	say $today->[0] if $yest->[1] < $today->[1];
}
