#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where * > 0 = 10) {
   .put for (1 .. *).grep({$_ == 1 || .is-prime}).produce(&[*]).[^$n];
}
