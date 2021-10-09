#!/usr/bin/perl

=head1

Week 132:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-132

Task #1: Mirror Dates

    You are given a date (yyyy/mm/dd).

    Assuming, the given date is your date of birth. Write a script to find the mirror dates of the given date.

=cut

use strict;
use warnings;

use Date::Calc qw(Today Date_to_Days Add_Delta_Days);

my $DATE = $ARGV[0];

my ($c_year, $c_month, $c_day) = Today();
my ($g_year, $g_month, $g_day) = split /\//, $DATE, 3;

my $days = Date_to_Days($c_year, $c_month, $c_day)
           -
           Date_to_Days($g_year, $g_month, $g_day);

print sprintf("%04d/%02d/%02d\n", Add_Delta_Days($g_year, $g_month, $g_day, -$days));
print sprintf("%04d/%02d/%02d\n", Add_Delta_Days($c_year, $c_month, $c_day,  $days));
