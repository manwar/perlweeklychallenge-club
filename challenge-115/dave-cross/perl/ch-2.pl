#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# The naive approach is to just sort the input integers
# in reverse order and print the result. But this doesn't
# guarantee that the output is an even number.
#
# So, we find the smallest even integer in our list and
# remove it. We then sort the remaining list and add the
# smallest even number to the end.

my @ints = get_ints();

my ($min_even, $min_even_idx);
# This is bigger than the bigger allowed input number
$min_even = 10;

while (my ($i, $v) = each @ints) {
  if ($v < $min_even and ! ($v % 2)) {
    $min_even     = $v;
    $min_even_idx = $i;
  }
}

splice @ints, $min_even_idx, 1;

print sort { $b <=> $a } @ints;
say $min_even;

sub get_ints {
  my @input = grep { /^\d$/ } @ARGV;

  die "Give me a list of positive integers under 10\n" unless @input;

  unless (grep { !($_ % 2) } @input) {
    die "There must be at least one even number in the list\n";
  }

  return @input;
}
