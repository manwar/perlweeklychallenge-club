#!/usr/bin/env perl6
use v6;

my %letters = ( 1, |( * X* 5, 10 ) … * ) Z=> ｢IVXLCDM｣.comb;

sub MAIN (
  UInt:D $number where * < 4e6, #= A positive integer.
  --> Nil
) {
  when $number < 4000 {
    say to-roman($number);
  }

  say [~] gather {
    for $number.comb.[0..*-4, *-3..*].pairs -> $pair {
      given to-roman($pair.value.join) {
        take $pair.key == 0
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
      when .value == 4 | 9 {
        take [~] %letters{ 10 ** .key X* 1, .value + 1 };
      }
      if .value ≥ 5 {
        take %letters{ 10 ** .key * 5 };
      }
      take %letters{ 10 ** .key } x .value % 5;
    }
  };
}

sub GENERATE-USAGE ( &main, |capture ) {
  (capture[0] ~~ UInt && capture[0] ≥ 4e6
    ?? "Error:\n  Numbers ≥ 4,000,000 not supported.\n\n"
    !! '')
    ~ $*USAGE;
}
