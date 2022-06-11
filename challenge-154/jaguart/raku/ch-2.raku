#!/usr/bin/env raku
use v6;

=begin pod
=begin CHALLENGE

TASK #2: Padovan Prime

Write a script to compute first 10 distinct Padovan Primes.

=end CHALLENGE
=end pod

# V2 - mark-anderson++ - wow :)
#   Uses lazy infinite list with generator,
#   Simple skip to eliminate the duplicate 1.

#| Generate Padovan sequence and print the first $n that are prime.
sub MAIN ( Int $n = 10 ) {

  # Notes:
  #   ...             -> infix sequence operator, produces sequence on demand
  #                   -> left-hand:  initial sequence and generator
  #                   -> right-hand: endpoint. * aka Whatever == infinite lazy seq
  # .grep(*.is-prime) -> only primes
  # .skip             -> skip first 1 to remove duplicate
  # .head($n)         -> first $n elements

  say .grep(*.is-prime).skip.head($n) with
    1, 1, 1, -> $a, $b, $ { $a + $b } ... *;


}

#| UNUSED - long-form Padovan sequence
sub next_padovan( @sofar ) returns Int {
  return @sofar.elems < 3
    ?? 1
    !! @sofar[*-3] + @sofar[*-2];
}

