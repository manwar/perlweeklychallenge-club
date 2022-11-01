#!/bin/perl

=pod

The Weekly Challenge - 189
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-189/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Greater Character
Submitted by: Mohammad S Anwar

You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array lexicographically
greater than the target character.

=cut

use v5.16;
use warnings;

use Test::More;

sub greaterCharacter {
  my $t = shift @_;
  (grep{$_ gt $t}sort @_)[0] // $t;
}

is(greaterCharacter('b', qw/e m u g/), 'e', 'Example 1');
is(greaterCharacter('a', qw/d c e f/), 'c', 'Example 2');
is(greaterCharacter('o', qw/j a r/),   'r', 'Example 3');
is(greaterCharacter('a', qw/d c a f/), 'c', 'Example 4');
is(greaterCharacter('v', qw/t g a l/), 'v', 'Example 5');

done_testing;
