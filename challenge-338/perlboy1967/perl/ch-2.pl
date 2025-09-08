#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-338#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Max Distance
Submitted by: Mohammad Sajid Anwar

You are given two integer arrays, @arr1 and @arr2.

Write a script to find the maximum difference between any pair of values from both arrays.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);

sub maxDistance ($arM1,$arM2) {
  max map { 
    my $i = $_; 
    map { abs($i-$_) } @$arM2 
  } @$arM1;
}

is(maxDistance([4,5,7],[9,1,3,4]),6,'Example 1');
is(maxDistance([2,3,5,4],[3,2,5,5,8,7]),6,'Example 2');
is(maxDistance([2,1,11,3],[2,5,10,2]),9,'Example 3');
is(maxDistance([1,2,3],[3,2,1]),2,'Example 4');
is(maxDistance([1,0,2,3],[5,0]),5,'Example 5');

done_testing;
