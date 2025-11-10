#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-347#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Format Date
Submitted by: Mohammad Sajid Anwar

You are given a date in the form: 10th Nov 2025.

Write a script to format the given date in the form: 2025-11-10 using the set below.

|| @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
|| @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
|| @YEARS  = (1900..2100)

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub formatData ($str) {
  state $M = { 'Jan' => 1, 'Feb' => 2, 'Mar' => 3, 
               'Apr' => 4, 'May' => 5, 'Jun' => 6,
               'Jul' => 7, 'Aug' => 8, 'Sep' => 9,
               'Oct' =>10, 'Nov' =>11, 'Dec' =>12};
  return sprintf('%d-%02d-%02d',$3,$M->{$2},$1)
   if $str =~ m/(\d+)\S+\s+([A-Z][a-z][a-z])\s+(\d+)/;
}

is(formatData('1st Jan 2025'),'2025-01-01','Example 1');
is(formatData('22nd Feb 2025'),'2025-02-22','Example 2');
is(formatData('15th Apr 2025'),'2025-04-15','Example 3');
is(formatData('23rd Oct 2025'),'2025-10-23','Example 4');
is(formatData('31st Dec 2025'),'2025-12-31','Example 5');

done_testing;
