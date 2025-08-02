#!/usr/bin/env raku
use v6;

use experimental :cached; 
sub bit_count($num) is cached {
  # convert to binary
  my $binary = $num.Int.base(2);
  # remove the 0s
  $binary ~~ s:g/0//;
  # what remains is just 1s
  return $binary.chars;
}

sub sortFunction($a, $b) {
  if    ( bit_count($a) > bit_count($b) ) { Order::More }
  elsif ( bit_count($a) < bit_count($b) ) { Order::Less }
  elsif ( $a > $b )                       { Order::More }
  elsif ( $a > $b )                       { Order::Less }
  else                                    { Order::Same }
}

sub sortByHammingWeight(@ints) {
  return @ints.sort: { sortFunction($^a, $^b) };
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @out = sortByHammingWeight(@ints);
  say 'Output: (' ~ @out.join(', ') ~ ')';
}

say "Example 1:";
solution([0, 1, 2, 3, 4, 5, 6, 7, 8]);

say "\nExample 2:";
solution([1024, 512, 256, 128, 64]);