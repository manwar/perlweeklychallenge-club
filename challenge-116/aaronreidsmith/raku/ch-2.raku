#!/usr/bin/env raku

sub challenge(Int $N where $N >= 10) returns Int {
  my $square-sum = $N.comb.map(*²).sum;
  $square-sum.sqrt.narrow ~~ Int ?? 1 !! 0;
}

multi sub MAIN(Int $N) {
  say challenge($N);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (34, 1),
    (50, 1),
    (52, 0)
  );

  for @tests -> ($N, $expected) {
    is(challenge($N), $expected);
  }

  done-testing;
}
