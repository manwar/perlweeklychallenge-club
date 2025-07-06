#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-328#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Good String
Submitted by: Mohammad Sajid Anwar

You are given a string made up of lower and upper case English letters only.

Write a script to return the good string of the given string. A string is called 
good string if it doesn’t have two adjacent same characters, one in upper case 
and other is lower case.

UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are 
same characters, one in lower case and other in upper case, order is not important.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::MoreUtils qw(pairwise);

sub goodString ($str) {
  state $re = join '|', 
                pairwise { "$a$b|$b$a" } 
                  @{['a'..'z']}, @{['A'..'Z']};
  1 while ($str =~ s#$re##g);
  return $str;
}

is(goodString('WeEeekly'),'Weekly','Example 1');
is(goodString('abBAdD'),'','Example 2');
is(goodString('abc'),'abc','Example 3');

done_testing;
