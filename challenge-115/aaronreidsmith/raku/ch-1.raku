#!/usr/bin/env raku

sub challenge(@S) returns Int {
  my @solutions = @S.race.permutations.grep: -> @permutation {
    my $valid = True;
    for @permutation Z (|@permutation[1..*], @permutation.head) -> ($a, $b) {
      if $a.comb.tail ne $b.comb.head {
        $valid = False;
        last;
      }
    }
    $valid;
  }
  (@solutions.elems > 0).Int;
}

multi sub MAIN(*@S where all(@S) ~~ Str) {
  say challenge(@S);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (('abc', 'dea', 'cd'), 1),
    (('ade', 'cbd', 'fgh'), 0)
  );

  for @tests -> (@S, $expected) {
    is(challenge(@S), $expected);
  }
}
