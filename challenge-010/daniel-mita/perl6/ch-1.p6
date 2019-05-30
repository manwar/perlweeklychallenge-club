#!/usr/bin/env perl6
use v6;
use lib $?FILE.IO.dirname;
use RomanNumerals;

my %*SUB-MAIN-OPTS = :named-anywhere;

multi MAIN (
  UInt:D $number where 0 < * < 4e9, #= A positive integer.
  --> Nil
) {
  say to-roman($number);
}

#| Not Yet Implemented
multi MAIN (
  Str:D $roman-numerals where { $_ !~~ UInt && .chars > 0 }
  --> Nil
) is hidden-from-USAGE {
  say &?ROUTINE.WHY;
}

multi MAIN (
  Str:D $roman-numerals where { $_ !~~ UInt && .chars > 0 }, #= A string of roman numerals.
  Bool:D :bruteforce(:$b) where *.so, #= Convert using bruteforce method.
  --> Nil
) {
  given |(
    @RomanNumerals::overlines.map( @RomanNumerals::letters X~ * ).reverse
  ), @RomanNumerals::letters -> @set {
    $roman-numerals.uc ~~ / ^ ( @(@set[0])+ )? ( @(@set[1])+ )? ( @(@set[2])+ )? $ /;
  }

  if $/ {
    given await gather {
      for $/[*].reverse.pairs -> $pair {
        take Promise.start({
          (1..^4000).race.map( * × 10 ** ($pair.key × 3) ).first(*.&to-roman eq $pair.value)
        }) if $pair.value;
      }
    } {
      if .all.so && .sum.&to-roman eq $roman-numerals.uc {
        .sum.say;
        return;
      }
    }
  }

  say "Error:\n  The input was not understood.\n\n" ~ $*USAGE;
}

sub GENERATE-USAGE ( &main, |capture ) {
    "Error:\n  Numbers ≥ 4,000,000,000 not supported.\n\n"
      x (capture[0] ~~ UInt && capture[0] ≥ 4e9) ~ $*USAGE;
}
