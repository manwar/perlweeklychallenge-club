#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

my constant @letters   = ｢IVXLCDM｣.comb;
my constant @overlines = "\c[combining overline]", "\c[combining double overline]";

my constant %letter-map = ( 1, |( * X* 5, 10 ) … ∞ ) Z=>
  |@letters, |( @overlines XR~ @letters[1..*] );

my constant %prefixes = %letter-map{ 10 X** 3, 6 } Z=> ( %letter-map<1> X~ @overlines );

multi MAIN (
  UInt:D $number where 0 < * < 4e9, #= A positive integer.
  --> Nil
) {
  say to-roman($number);
}

#| Not Yet Implemented
multi MAIN (
  Str:D $roman-numerals
  --> Nil
) is hidden-from-USAGE {
  say &?ROUTINE.WHY;
}

multi MAIN (
  Str:D $roman-numerals where *.chars > 0, #= A string of roman numerals.
  Bool:D :bruteforce(:$b) where *.so, #= Convert using bruteforce method.
  --> Nil
) {
  given |( @overlines.map(@letters X~ *).reverse ), @letters -> @set {
    $roman-numerals ~~ / ^ ( @(@set[0])+ )? ( @(@set[1])+ )? ( @(@set[2])+ )? $ /;
  }

  if $/ {
    given await gather {
      take Promise.start( { (1..^4000).race.map(* * 1e6).first(*.&to-roman eq $0) } ) if $0;
      take Promise.start( { (1..^4000).race.map(* * 1e3).first(*.&to-roman eq $1) } ) if $1;
      take Promise.start( { (1..^4000).race.first(*.&to-roman eq $2) } ) if $2;
    } {
      if .all.so && .sum.&to-roman eq $roman-numerals.uc {
        .sum.say;
        return;
      }
    }
  }

  say "Error:\n  The input was not understood.\n\n" ~ $*USAGE;
}

sub to-roman (
  UInt() $_,
  --> Str:D
){
  return [~] gather {
    for .flip.comb.pairs.reverse {
      given 10 ** .key -> $key {
        when .value == 4 | 9 {
          take %prefixes{ %letter-map{$key} } || %letter-map{$key};
          take %letter-map{ $key * (.value + 1) };
        }
        if .value ≥ 5 {
          take %letter-map{ $key * 5 };
        }
        take %letter-map{ $key } x .value % 5;
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
