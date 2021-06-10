#!/usr/bin/env raku

sub challenge(@nums where @nums.elems == 7) returns Str {
  my @solution = @nums
    .sort
    .permutations
    .reverse
    .first: -> ($a, $b, $c, $d, $e, $f, $g) {
      $a + $b == $b + $c + $d &&
      $b + $c + $d == $d + $e + $f &&
      $d + $e + $f == $f + $g
    };

  # If nothing is found, the above returns `[(Any)]` rather than nothing
  # This is only because we assign to a variable; otherwise it returns `Nil`
  if @solution.elems == 1 {
    "Unable to find a solution for given input.";
  } else {
    (<a b c d e f g> Z @solution)
      .map(-> ($key, $value) { "$key = $value" })
      .join("\n");
  }
}

multi sub MAIN(*@nums where all(@nums) ~~ Int) {
  say challenge(@nums);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    ((1, 2, 3, 4, 5, 6, 7), "a = 7\nb = 3\nc = 2\nd = 5\ne = 1\nf = 4\ng = 6"),
    ((14, 17, 2, 9, -1, 100, 17), "Unable to find a solution for given input.")
  );

  for @tests -> (@input, $expected) {
    is(challenge(@input), $expected);
  }

  done-testing;
}
