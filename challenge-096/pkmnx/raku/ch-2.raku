#!/usr/bin/env raku

#
# See as alg directly used from: https://en.wikipedia.org/wiki/Levenshtein_distance
# And see usage:
#
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-096/pkmnx/raku$ time ./ch-2.raku kitten sitting
#  3
#  real    0m0.339s ...
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-096/pkmnx/raku$ time ./ch-2.raku sunday monday
#  2
#  real    0m0.359s ...
#

sub MAIN( Str $S1, Str $S2 ) {
  lev( $S1.comb(), $S2.comb() ).say;
}

sub lev( $a, $b ) {
   return $a.elems if $b.elems == 0;
   return $b.elems if $a.elems == 0;
   return lev( $a.tail($a.elems -1), $b.tail($b.elems -1) ) if $a[0] eq $b[0];
   return 1 + min(
      lev( $a.tail($a.elems -1), $b ),
      lev( $a, $b.tail($b.elems -1) ),
      lev( $a.tail($a.elems -1), $b.tail($b.elems -1) )
   )
}
