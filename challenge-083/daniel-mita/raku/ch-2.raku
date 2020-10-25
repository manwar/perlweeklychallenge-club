#!/usr/bin/env raku

sub MAIN(
  *@positive-ints where { .elems > 0 && .all ~~ Int && .all > 0 }
  --> Nil
) {
  @(
    @positive-ints.combinations(1..*)
      .grep( *.sum ≤ @positive-ints.sum / 2 )
      .sort({ $^b.sum <=> $^a.sum || $a.elems <=> $b.elems })
  )[0].elems.say;
}
