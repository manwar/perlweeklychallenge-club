#!/usr/bin/env perl
use v5.38;

sub diStringMatch($str) {
  my @permutation;
  # first, generate the list of integers
  # we're making permutations of
  my @nums = 0 .. length($str);
  # now let's generate our permutation
  foreach my $c ( split(//, $str) ) {
    if ($c eq 'D') {
      # take the largest number available
      push @permutation, pop(@nums);
    }
    else {
      # take the smallest number available
      push @permutation, shift(@nums);
    }
  }
  # add last remaining number
  push @permutation, $nums[0];

  return @permutation;
}

sub solution($str) {
  say qq{Input: \$str = '$str'};
  my @permutation = diStringMatch($str);
  say 'Output: (' . join(', ', @permutation) . ')';
}

say "Example 1:";
solution("IDID");

say "\nExample 2:";
solution("III");

say "\nExample 3:";
solution("DDI");