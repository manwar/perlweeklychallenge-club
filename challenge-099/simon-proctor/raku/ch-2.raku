#!/usr/bin/env raku

use v6;

#| Given two strings see how often you can find sequences of the second string in the first.
sub MAIN( Str $S, Str $T ) {
    say sub-count($S.comb, $T.comb);
}

multi sub sub-count( @ where *.elems == 0, @ where *.elems > 0 ) { 0 }
multi sub sub-count( @, @ where *.elems == 0 ) { 1 }

multi sub sub-count( @S, @T where @S[0] ~~ @T[0] ) {
    return sub-count( @S[1..*], @T[1..*] )
         + sub-count( @S[1..*], @T ); 
}

multi sub sub-count( @S, @T ) {
    return sub-count( @S[1..*], @T );
}
