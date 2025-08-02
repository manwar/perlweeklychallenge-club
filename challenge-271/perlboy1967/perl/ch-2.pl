#!/bin/perl

=pod

The Weekly Challenge - 271
- https://theweeklychallenge.org/blog/perl-weekly-challenge-271

Author: Niels 'PerlBoy' van Dijke

Task 2: Sort by 1 bits
Submitted by: Mohammad Sajid Anwar

You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits
in their binary representation. In case more than one integers have the same
number of 1 bits then sort them in ascending order.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use Memoize qw(memoize);

memoize('d2b');

sub d2b ($int) { sprintf('%0b',$int) }

sub sortBy1bits (@ints) {
  sort{
    my ($a1,$b1) = (d2b($a),d2b($b));
    $a1 =~ tr/1/1/ <=> $b1 =~ tr/1/1/ || $a <=> $b
  } @ints;
}

is([sortBy1bits(0,1,2,3,4,5,6,7,8)],
               [0,1,2,4,8,3,5,6,7],'Example 1');
is([sortBy1bits(1024,512,256,128,64)],
               [64,128,256,512,1024],'Example 2');

done_testing;
