#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-372#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Rearrange Spaces
Submitted by: Mohammad Sajid Anwar
You are given a string text of words that are placed among number of spaces.

Write a script to rearrange the spaces so that there is an equal number of spaces
between every pair of adjacent words and that number is maximised. If you can’t
distribute, place the extra speaces at the end. Finally return the string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub rearrangeSpaces ($str) {
  # Get number of spaces
  my $s = $str =~ tr/ / /;
  # Get words
  my @w = grep { length } split/\s+/,$str;
  # Return the new string
  if (scalar @w < 2) {
    # One (or zero)
    return shift(@w) . ' ' x $s;
  } else {
    # Two or more
    my $w = int($s/(scalar(@w)-1));
    $s -= $w * (scalar(@w) - 1);
    return join(' ' x $w,@w) . ' ' x $s;
  }
}

is(rearrangeSpaces('  challenge  '),'challenge    ','Example 1');
is(rearrangeSpaces('coding  is  fun'),'coding  is  fun','Example 2');
is(rearrangeSpaces('a b c  d'),'a b c d ','Example 3');
is(rearrangeSpaces('  team  pwc  '),'team      pwc','Example 4');
is(rearrangeSpaces('   the  weekly  challenge  '),'the    weekly    challenge ','Example 5');

done_testing;
