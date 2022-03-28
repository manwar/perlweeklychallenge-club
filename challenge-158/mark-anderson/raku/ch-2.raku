#!/usr/bin/env raku

say first-series(1000);

sub first-series(\n)
{
    my @s = (1..*).map(* ** 3)
                  .rotor(2 => -1)
                  .map({.[1] - .[0]})
                  .grep(&is-prime);

   my \elems = @s.first(* > n, :k);

   @s.head(elems)
}
