#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @words = get_words();

# For a list of words to be able to form a string chain,
# the set of first letters must be the same as the set of
# last letters.

my (@first, @last);

# Get arrays containing the first and last letters
for (@words) {
  push @first, substr $_,  0, 1;
  push @last,  substr $_, -1, 1;
}

# Sort the arrays, join them into string and see if they're
# the same.
say +(join('', sort @first) eq join('', sort @last)) ? 1 : 0;

sub get_words {
  my @input = map { lc } grep { ! /[^a-z]/i } @ARGV;

  die "Give me a list of words\n" unless @input;

  return @input;
}
