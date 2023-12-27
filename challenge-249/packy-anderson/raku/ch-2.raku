#!/usr/bin/env raku
use v6;

sub diStringMatch($str) {
  my @permutation;
  # first, generate the list of integers
  # we're making permutations of
  my @nums = 0 .. $str.chars;
  # now let's generate our permutation
  for $str.split('', :skip-empty) -> $c {
    if ($c eq 'D') {
      # take the largest number available
      @permutation.push( @nums.pop() );
    }
    else {
      # take the smallest number available
      @permutation.push( @nums.shift() );
    }
  }
  # add last remaining number
  @permutation.push( @nums[0] );

  return @permutation;
}

sub solution($str) {
  say qq{Input: \$str = '$str'};
  my @permutation = diStringMatch($str);
  say 'Output: (' ~ @permutation.join(', ') ~ ')';
}

say "Example 1:";
solution("IDID");

say "\nExample 2:";
solution("III");

say "\nExample 3:";
solution("DDI");