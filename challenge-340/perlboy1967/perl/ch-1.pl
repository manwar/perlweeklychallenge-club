#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-340#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Duplicate Removals
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have
been made. Repeat duplicate removals on the given string until we no longer can.

|| A duplicate removal consists of choosing two adjacent and equal letters andi
|| removing them.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub removeDuplicates ($str) {
  1 while ($str =~ s#(.)(\1)##);
  $str;
}

is(removeDuplicates('abbaca'),'ca','Example 1');
is(removeDuplicates('azxxzy'),'ay','Example 2');
is(removeDuplicates('aaaaaaaa'),'','Example 3');
is(removeDuplicates('aabccba'),'a','Example 4');
is(removeDuplicates('abcddcba'),'','Example 5');

done_testing;
