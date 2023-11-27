#!/usr/bin/env perl
use v5.38;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw( min max sum );

sub power {
  my $list = shift;
  return( (max(@$list) ** 2) * min(@$list) );
}

sub groupHero(@nums) {
  return sum(
    # generate the list of powers for each combination
    map { power($_) }
    # generate the list of combinations
    map { combinations(\@nums, $_) } 1 .. scalar(@nums)
  );
}

sub solution {
  my @nums = @_;
  say 'Input: @int = (' . join(', ', @nums) . ')';
  my $output = groupHero(@nums);
  say 'Output: ' . $output;
}

say "Example 1:";
solution(2, 1, 4);
