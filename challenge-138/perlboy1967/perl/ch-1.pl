#!/bin/perl

=pod

The Weekly Challenge - 138
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-138/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Workdays
Submitted by: Mohammad S Anwar

You are given a year, $year in 4-digits form.

Write a script to calculate the total number of workdays in the given year.

 ||  For the task, we consider, Monday - Friday as workdays.

=cut

use v5.16;
use strict;
use warnings;

use Date::Calc qw(Day_of_Week Week_of_Year);

use Test::More;

my %tests = (
  2000 => 260, 2001 => 261, 2002 => 261, 2003 => 261,
  2004 => 262, 2005 => 260, 2006 => 260, 2007 => 261,
  2008 => 262, 2009 => 261, 2010 => 261, 2011 => 260,
  2012 => 261, 2013 => 261, 2014 => 261, 2015 => 261,
  2016 => 261, 2017 => 260, 2018 => 261, 2019 => 261,
  2020 => 262, 2021 => 261, 2022 => 260, 2023 => 260,
  2024 => 262, 2025 => 261, 2026 => 261, 2027 => 261,
);

foreach my $y (sort { $a <=> $b } keys %tests) {
  my ($dayOfWeek1,$dayOfWeek2) = (Day_of_Week($y,1,1),Day_of_Week($y,12,31));

  my $workingDays = 262;
  $workingDays-- if ($dayOfWeek1 > 5);
  $workingDays-- if ($dayOfWeek2 > 5);
  $workingDays-- if ($dayOfWeek1 == $dayOfWeek2 and $dayOfWeek1 < 6);

  is($workingDays,$tests{$y},"year=$y");
}

done_testing;
