#!/usr/bin/env raku

# see usage:
#
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-092/pkmnx/raku$ ./ch-01.raku "abc" "xyz"
#  Input: $A = "abc"; $B = "xyz"
#  Output: 1
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-092/pkmnx/raku$ ./ch-01.raku "abb" "xyy"
#  Input: $A = "abb"; $B = "xyy"
#  Output: 1
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-092/pkmnx/raku$ ./ch-01.raku "sum" "add"
#  Input: $A = "sum"; $B = "add"
#  Output: 0

sub MAIN( Str $A, Str $B ) {

  my $fn = sub ($x) {
     my $h = {};
     $x.comb().map({ $h{$_}++ });
     $h.values.sort().join("|");
  };

  printf( "Input: \$A = \"%s\"; \$B = \"%s\"\n", $A, $B ); 
  printf( "Output: %s\n", ($fn($A) ~~ $fn($B) ?? 1 !! 0 ) );

}
