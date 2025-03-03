#!/bin/perl

=pod

The Weekly Challenge - 311
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-311#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Group Digit Sum
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of digits, and an integer, $int,
which is less than the length of the given string.

Write a script to divide the given string into consecutive groups of size
$int (plus one for leftovers if any). Then sum the digits of each group,
and concatenate all group sums to create a new string. If the length of 
the new string is less than or equal to the given integer then return the
new string, otherwise continue the process.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::Util qw(sum);

sub groupDigitSum ($str,$gLen) {
  my $re = join('',map { "(?<d$_>.)" } 1 .. $gLen);
  while (length($str) > $gLen) { 
    $str =~ s/$re/sum(values %+)/ge;
  }
  return $str;
}

is(groupDigitSum('111122333',3),359,'Example 1');
is(groupDigitSum('1222312',2),76,'Example 2');
is(groupDigitSum('100012121001',4),162,'Example 3');

done_testing;
