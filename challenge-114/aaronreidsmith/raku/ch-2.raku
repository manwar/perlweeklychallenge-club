#!/usr/bin/env raku

sub bits(Int $base-ten) returns Int {
  $base-ten.base(2).comb.grep(* eq '1').elems;
}

sub challenge(Int $N where $N > 0) returns Int {
  my $bits = bits($N);
  ($N^..Inf).first(-> $num { bits($num) == $bits }, :v);
}

multi sub MAIN(Int $N) {
  say challenge($N);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (1, 2),
    (3, 5),
    (12, 17)
  );

  for @tests -> ($N, $expected) {
    is(challenge($N), $expected);
  }

  done-testing;
}
