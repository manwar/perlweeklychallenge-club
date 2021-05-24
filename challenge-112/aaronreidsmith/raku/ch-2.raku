#!/usr/bin/env raku

use experimental :cached;

sub challenge(
  $max where Int,
  @paths where Positional = (^$max),
  $current-step where Int = 0
) is cached {
  given $current-step {
    when * == $max { 1 }
    when * > $max  { 0 }
    default {
      challenge($max, @paths, $current-step + 1) +
      challenge($max, @paths, $current-step + 2)
    }
  }
}

multi sub MAIN(Int $n) {
  say challenge($n);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (3, 3),
    (4, 5),
    (10, 89)
  );

  for @tests -> ($n, $expected) {
    is(challenge($n), $expected);
  }

  done-testing;
}
