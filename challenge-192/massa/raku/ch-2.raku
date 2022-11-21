#!/usr/bin/env raku

=begin pod

Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task #2: Equal Distribution

    You are given a list of integers greater than or equal to zero, @list.

    Write a script to distribute the number so that each members are same. If
    you succeed then print the total moves otherwise print -1.

    Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

    1) You can only move a value of '1' per move
    2) You are only allowed to move a value of '1' to a direct
    neighbor/adjacent cell

=end pod

use Test;

is 4,  equal-distribution <1 0 5>;
is -1, equal-distribution <0 2 0>;
is 2,  equal-distribution <0 3 0>;

done-testing;

sub equal-distribution(@list) {
  $_ = @list».Int.Array;
  return -1 if .sum !%% .elems;
  my \mean-element = .sum div .elems;
  my $count = 0;
  while $_ > 1 {
    my \difference = .shift - mean-element;
    .[0] += difference;
    $count += difference.abs
  }
  $count
}

