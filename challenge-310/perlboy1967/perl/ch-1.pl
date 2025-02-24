#!/bin/perl

=pod

The Weekly Challenge - 310
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-310#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Arrays Intersection
Submitted by: Mohammad Sajid Anwar

You are given a list of array of integers.

Write a script to return the common elements in all the arrays.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::Util qw(min);

sub arrayIntersection {
  my %in;
  map { my $i = $_; map { $in{$_[$i][$_]}{$i}++ } 0 .. $#{$_[$_]} } 0 .. $#_;
  map { $in{$_} = keys %{$in{$_}} == @_ ? min(values %{$in{$_}}) : 0 } keys %in;
  map { ($_) x $in{$_} } sort { $a <=> $b } keys %in;
}

is([arrayIntersection([1,2,3,4],[4,5,6,1],[4,2,1,3])],
   [1,4],'Example 1');
is([arrayIntersection([1,0,2,3],[2,4,5])],
   [2],'Example 2');
is([arrayIntersection([1,2,3],[4,5],[6])],
   [],'Example 3');
is([arrayIntersection([1,1,2],[1,2,1],[2,1,1])],
   [1,1,2],'Own test 1');
is([arrayIntersection([1,1,1,1,2,2],[2,2],[1,1,2,2])],
   [2,2],'Own test 2');

done_testing;
