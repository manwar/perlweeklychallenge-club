#!/usr/bin/env raku
use v6;

sub power(@nums) {
  return( (@nums.max ** 2) * @nums.min );
}

sub groupHero(@nums) {
  return [+] (
    power($_) for @nums.combinations: 1 .. @nums.elems
  );
}

sub solution(*@nums) {
  say 'Input: @int = (' ~ @nums.join(', ') ~ ')';
  my $output = groupHero(@nums);
  say 'Output: ' ~ $output;
}

say "Example 1:";
solution(2, 1, 4);
