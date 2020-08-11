#!/usr/bin/perl
#
# Challenge 1: "Write a script to list dates for Sunday Christmas between
#	      2019 and 2100. For example, 25 Dec 2022 is Sunday."
#
# My notes: Very well defined, another job for Date::Manip or Date::Simple..
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Date::Simple qw(date today);

die "Usage: ch-1.pl [STARTYEAR [ENDYEAR]]\n" if @ARGV > 2;
my $startyear = shift // 2019;
my $endyear = shift // 2100;

foreach my $year ($startyear..$endyear)
{
	my $dstr = "$year-12-25";
	my $dow = date( $dstr )->day_of_week;
	say $dstr if $dow == 0;
}
