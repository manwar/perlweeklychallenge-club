#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-359#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Digital Root
Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a function that calculates the additive persistence of a positive integer and also return the digital root.

||  Digital root is the recursive sum of all digits in a number until a single digit is obtained.
||
||  Additive persistence is the number of times you need to sum the digits to reach a single digit.


=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::AllUtils qw(sum);

sub digitalRoot ($int) {
  my $persistence = 0;
  $persistence++ while ($int > 9 and $int = sum split //,$int);
  return $persistence,$int;
}

is([digitalRoot(38)],[2,2],'Example 1');
is([digitalRoot(7)],[0,7],'Example 2');
is([digitalRoot(999)],[2,9],'Example 3');
is([digitalRoot(1999999999)],[3,1],'Example 4');
is([digitalRoot(101010)],[1,3],'Example 5');

done_testing;
