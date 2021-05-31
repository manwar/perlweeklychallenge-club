#!/usr/bin/env raku

sub challenge(Int $N) returns Int {
  ($N^..Inf).first(-> $num { $num == $num.flip }, :v);
}

multi sub MAIN(Int $N) {
  say challenge($N);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (1234, 1331),
    (999, 1001)
  );

  for @tests -> ($N, $expected) {
    is(challenge($N), $expected);
  }

  done-testing;
}
