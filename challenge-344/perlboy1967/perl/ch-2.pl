#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-344#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Array Formation
Submitted by: Mohammad Sajid Anwar

You are given two list: @source and @target.

Write a script to see if you can build the exact @target by putting these
smaller lists from @source together in some order. You cannot break apart
or change the order inside any of the smaller lists in @source.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use Algorithm::Combinatorics qw(variations);

sub arrayFormation ($arSrc,$arDst) {
  my @src = map { join(',',@$_) } @$arSrc;
  my $dst = join(',',@$arDst); 
  for my $a (variations(\@src,$#src + 1)) {
    return true if (join(',',@$a) eq $dst);
  }
  return false;
}

is(arrayFormation([[2,3],[1],[4]],[1,2,3,4]),true,'Example 1');
is(arrayFormation([[1,3],[2,4]],[1,2,3,4]),false,'Example 2');
is(arrayFormation([[9,1],[5,8],[2]],[5,8,2,9,1]),true,'Example 3');
is(arrayFormation([[1],[3]],[1,2,3]),false,'Example 4');
is(arrayFormation([[7,4,6]],[7,4,6]),true,'Example 5');
is(arrayFormation([[1,1,1],[0,1],[1],[0,0]],[0,1,1,1,1,1,0,0]),true,'Own example');

done_testing;
