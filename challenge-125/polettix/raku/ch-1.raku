#!/usr/bin/env raku
use v6;

sub pythagorean-triples (Int:D $N where * > 0) {

   # this finds all possible (distinct) ways of expressing $n as a
   # product of two positive integers. The first item is by definition
   # lower than, or equal to, the second so that we know that only
   # distinct pairs are considered; this also means that the first
   # element cannot be greater than sqrt($n)
   sub factor-in-pairs ($n) {
      (1 .. sqrt($n))            # first element 1 .. sqrt($n)
         .grep({$n %% $_})       # make sure first element divides $n
         .map({($_, $n / $_)});  # take it and its counterpart
   }

   # I know that gather/take is slow... but it's too cool
   gather {
      # https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Dickson's_method
      # parameter $r spans positive even integers
      R: # this marks the outer loop, for exiting lazy iteration
      for 2, 4, 6 ... Inf -> $r {
         for factor-in-pairs($r²/2) -> ($s, $t) {
            my @triple = ($r + $s, $r + $t, $r + $s + $t);

            # if the very first triple's first element is over $N,
            # our iteration is over because any element will be
            # greater than $N from now on
            last R if $s == 1 && $N < @triple[0];

            # only take the triple if it contains our target $N
            take @triple if $N == @triple.any;
         }
      }
   }
}

sub MAIN (Int:D $N = 5) {
   my @triples = pythagorean-triples($N);
   if @triples { put '(' ~ $_.join(', ') ~ ')' for @triples }
   else        { put -1 }
}
