#!/usr/bin/env raku

sub challenge(@N) returns Int {
  @N.race.permutations.map(*.join.Int).grep(* %% 2).max;
}

multi sub MAIN(*@N where all(@N) ~~ /^<digit>$/) {
  say challenge(@N);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    ((1, 0, 2, 6), 6210),
    ((1, 4, 2, 8), 8412),
    ((4, 1, 7, 6), 7614)
  );

  for @tests -> (@N, $expected) {
    is(challenge(@N), $expected);
  }

  done-testing;
}
