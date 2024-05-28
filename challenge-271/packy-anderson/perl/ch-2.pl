#!/usr/bin/env perl
use v5.38;

use Memoize;
memoize('bit_count');
sub bit_count($num) {
  # convert to binary
  my $binary = unpack("B32", pack("N", $num));
  # remove the 0s
  $binary =~ s/0//g;
  # what remains is just 1s
  return length($binary);
}

sub sortByHammingWeight(@ints) {
  return sort {
    bit_count($a) <=> bit_count($b)
    ||
    $a <=> $b
  } @ints;
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my @out = sortByHammingWeight(@ints);
  say 'Output: (' . join(', ', @out) . ')';
}

say "Example 1:";
solution(0, 1, 2, 3, 4, 5, 6, 7, 8);

say "\nExample 2:";
solution(1024, 512, 256, 128, 64);