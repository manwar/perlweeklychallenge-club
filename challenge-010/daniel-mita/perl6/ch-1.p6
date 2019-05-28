#!/usr/bin/env perl6
use v6;

my %letters = ( Ⅰ, |( * X* Ⅴ, Ⅹ ) … * ) Z=> ｢IVXLCDM｣.comb;

sub MAIN (
  UInt:D $number where Ⅰ ≤ * < Ⅳ × Ⅹ**Ⅲ #= A positive integer.
) {
  say [~] gather {
    for $number.flip.comb.pairs.reverse {
      when .value == Ⅳ | Ⅸ {
        take [~] ( %letters{ Ⅹ ** .key X* Ⅰ, .value + Ⅰ } );
      }
      if .value ≥ Ⅴ {
        take %letters{ Ⅹ ** .key * Ⅴ };
      }
      take %letters{ Ⅹ ** .key } x .value % Ⅴ;
    }
  }
}

sub GENERATE-USAGE ( &main, |capture ) {
  (capture.first ~~ UInt && capture.first ≥ Ⅳ × Ⅹ**Ⅲ
    ?? "Error:\n  Support for numbers greater than MMMCMXCIX not yet implemented.\n\n"
    !! '')
    ~ $*USAGE;
}
