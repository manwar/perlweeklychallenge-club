#!/usr/bin/env perl6
use v6;

my %letters = ( Ⅰ, |( * X* Ⅴ, Ⅹ ) … * ) Z=> ｢IVXLCDM｣.comb;

sub MAIN (
  UInt:D $number where * < Ⅳ * Ⅹ**Ⅵ, #= A positive integer.
  --> Nil
) {
  when $number < Ⅳ * Ⅿ {
    say to-roman($number);
  }

  say [~] gather {
    for $number.comb.[*-*..*-Ⅳ, *-Ⅲ..*].pairs -> $pair {
      given to-roman($pair.value.join) {
        take $pair.key < Ⅰ
          ?? .comb.map(* ~ "\c[combining overline]").join.subst(/I̅ <![V̅X̅]>/, 'M', :g)
          !! $_;
      }
    }
  };
}

sub to-roman (
  UInt() $_ --> Str:D
) {
  return [~] gather {
    for .flip.comb.pairs.reverse {
      when .value == Ⅳ | Ⅸ {
        take [~] %letters{ Ⅹ ** .key X* Ⅰ, .value + Ⅰ };
      }
      if .value ≥ Ⅴ {
        take %letters{ Ⅹ ** .key * Ⅴ };
      }
      take %letters{ Ⅹ ** .key } x .value % Ⅴ;
    }
  };
}

sub GENERATE-USAGE ( &main, |capture ) {
  (capture.first ~~ UInt && capture.first ≥ Ⅳ × Ⅹ**Ⅵ
    ?? "Error:\n  Numbers > M̅M̅M̅C̅M̅X̅C̅I̅X̅CMXCIX not supported.\n\n"
    !! '')
    ~ $*USAGE;
}
