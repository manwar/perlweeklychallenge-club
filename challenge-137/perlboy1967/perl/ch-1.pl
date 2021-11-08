#!/bin/perl

=pod

Perl Weekly Challenge - 137
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-137/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Long Year
Submitted by: Mohammad S Anwar

Write a script to find all the years between 1900 and 2100 which is a Long Year.

 ||    A year is Long if it has 53 weeks.

=cut

use v5.16;
use strict;
use warnings;

use Date::Calc qw(Week_of_Year);

my @w53years;
foreach my $y (1900 .. 2099) {
  push(@w53years,$y) if Week_of_Year($y,12,31) == 53;
}

printf "Years: %s\n", join(', ', @w53years);
