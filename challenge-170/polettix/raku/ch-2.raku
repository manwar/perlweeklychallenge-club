#!/usr/bin/env raku
use v6;
sub MAIN {
   .say for kronecker-product([ <1 2>, <3 4> ],
                              [ <5 6>, <7 8> ]);
}

sub kronecker-product (@a, @b) {
   (@a X @b).map(->(@A, @B) { @A X* @B });
}

sub kronecker_product (@a, @b) {
   (@a X @b).map: { .[0].list X* .[1].list };
}
