#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-351#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Arithmetic Progression
Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.

Write a script to return true if the given array can be re-arranged to form
an arithmetic progression, otherwise return false.

|| A sequence of numbers is called an arithmetic progression if the difference
|| between any two consecutive elements is the same.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;

use List::MoreUtils qw(slide frequency);

sub isArithmeticProgression (@num) {
 boolean(keys %{{frequency slide { $b - $a } sort {$a <=> $b} @num}} == 1);
}

is(isArithmeticProgression(1,3,5,7,9),true,'Example 1');
is(isArithmeticProgression(9,1,7,5,3),true,'Example 2');
is(isArithmeticProgression(1,2,4,8,16),false,'Example 3');
is(isArithmeticProgression(5,-1,3,1,-3),true,'Example 4');
is(isArithmeticProgression(1.5,3,0,4.5,6),true,'Example 5');

done_testing;
