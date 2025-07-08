#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-329#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Counter Integers
Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to replace every non-digit character with a space and then 
return all the distinct integers left.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(uniq);

sub countIntegers ($str) {
  uniq $str =~ m#\d+#g;
}

is([countIntegers('the1weekly2challenge2')],[1,2],'Example 1');
is([countIntegers('go21od1lu5c7k')],[21,1,5,7],'Example 2');
is([countIntegers('4p3e2r1l')],[4,3,2,1],'Example 3');

done_testing;
