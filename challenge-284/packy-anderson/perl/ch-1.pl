#!/usr/bin/env perl
use v5.40;

sub luckyInteger(@ints) {
  # thanks to Niels van Dijke (https://github.com/PerlBoy1967)
  # for putting postfix "for" back in my brain!
  my %bag; $bag{$_}++ for @ints; # count occurrences

  my @lucky;
  foreach my($k, $v) (%bag) { # get key/value pairs
    next unless $k == $v; # skip keys that don't match freq
    push @lucky, $k;
  }

  return -1 if @lucky == 0; # return -1 if no lucky int was found
  return (sort @lucky)[-1]; # return the largest lucky int
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  say 'Output: ' . luckyInteger(@ints);
}

say "Example 1:";
solution(2, 2, 3, 4);

say "\nExample 2:";
solution(1, 2, 2, 3, 3, 3);

say "\nExample 3:";
solution(1, 1, 1, 3);