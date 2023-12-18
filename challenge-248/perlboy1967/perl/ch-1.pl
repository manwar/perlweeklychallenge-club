#!/bin/perl

=pod

The Weekly Challenge - 248
- https://theweeklychallenge.org/blog/perl-weekly-challenge-248

Author: Niels 'PerlBoy' van Dijke

Task 1: Shortest Distance
Submitted by: Mohammad S Anwar

You are given a string and a character in the given string.

Write a script to return an array of integers of size same as length of the given string such that:

distance[i] is the distance from index i to the closest occurence of
the given character in the given string.

The distance between two indices i and j is abs(i - j).

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

use List::MoreUtils qw(indexes);
use List::Util qw(min);

sub shortestDistance($str,$ch) {
 my @ch = split //, $str;
 my @idx = indexes { $_ eq $ch } @ch;

 map { 
   my $i = $_; $ch[$_] eq $ch ? 0 : min(map { abs($i - $_) } @idx);
 } 0 .. $#ch;
}

is([shortestDistance('loveleetcode','e')],[3,2,1,0,1,0,0,1,2,2,1,0]);
is([shortestDistance('aaab','b')],[3,2,1,0]);

done_testing;
