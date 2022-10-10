#!/bin/perl

=pod

The Weekly Challenge - 184
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-184/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Sequence Number
Submitted by: Mohammad S Anwar

You are given list of strings in the format aa9999 i.e. first 2 characters can be 
anything 'a-z' followed by 4 digits '0-9'.

Write a script to replace the first two characters with sequence starting with 
'00', '01', '02' etc.

=cut

use v5.16;
use warnings;

use Test::More;
use Test::Deep qw(cmp_deeply);


sub seqNr (@) {
  my ($i,@s) = (0,@_);
  map { s/^../sprintf('%02d',$i++)/re; } @s;
}


cmp_deeply([seqNr(qw(ab1234 cd5678 ef1342))],[qw(001234 015678 021342)]);
cmp_deeply([seqNr(qw(pq1122 rs3334))],[qw(001122 013334)]);

done_testing;
