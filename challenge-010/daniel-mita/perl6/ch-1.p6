#!/usr/bin/env perl6
use v6;

my constant @overlines = "\c[combining overline]", "\c[combining double overline]";

my constant %letters = ( 1, |( * X* 5, 10 ) … ∞ ) Z=>
  'I', |('', |@overlines XR~ ｢VXLCDM｣.comb );

my constant %prefixes = %letters{ 10 X** 3, 6 } Z=> ( %letters<1> X~ @overlines );

multi MAIN (
  UInt:D $number where 0 < * < 4e9, #= A positive integer.
  --> Nil
) {
  say to-roman($number);
}

#| Not Yet Implemented
multi MAIN (
  Str:D $roman-numerals
    where *.uc.comb ⊆ (%letters, %prefixes).map(*.values).flat, #= A string of roman numerals.
  --> Nil
) {
  say &?ROUTINE.WHY;
}

sub to-roman (
  UInt() $_,
  --> Str:D
){
  return [~] gather {
    for .flip.comb.pairs.reverse {
      given 10 ** .key -> $key {
        when .value == 4 | 9 {
          take %prefixes{ %letters{$key} } || %letters{$key};
          take %letters{ $key * (.value + 1) };
        }
        if .value ≥ 5 {
          take %letters{ $key * 5 };
        }
        take %letters{ $key } x .value % 5;
      }
    }
  };
}

sub GENERATE-USAGE ( &main, |capture ) {
  (capture[0] ~~ UInt && capture[0] ≥ 4e9
    ?? "Error:\n  Numbers ≥ 4,000,000,000 not supported.\n\n"
    !! '')
    ~ $*USAGE;
}
