#!/usr/bin/env raku

subset PositiveInt of Int where * > 0;

sub challenge(PositiveInt $N, PositiveInt $D) returns Int {
  my $output = (1..^$N)
    .race
    .grep(*.contains($D))
    .combinations(2..*)
    .map(*.sum)
    .any == $N;
  $output.Bool.Int;
}

multi sub MAIN(PositiveInt $N, PositiveInt $D) {
  say challenge($N, $D);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (25, 7, 0),
    (24, 7, 1),
    (97, 4, 1)
  );

  for @tests -> ($N, $D, $expected) {
    is(challenge($N, $D), $expected);
  }

  done-testing;
}
