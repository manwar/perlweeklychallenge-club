#!/usr/bin/env raku

sub MAIN(
  *@positive-nums where { .elems > 0 && .all.Rat && .all > 0 }
  --> Nil
) {
  @(
    @positive-nums.combinations(1..*)
      .grep( *.sum ≤ @positive-nums.sum / 2 )
      .sort({ $^b.sum <=> $^a.sum || $a.elems <=> $b.elems })
  )[0].elems.say;
}
