#!/usr/bin/env raku

use v6;

#| Given two strings return the Levenshtein distance between them
sub MAIN( Str $a, Str $b ) {
    say l-dist( $a, $b );
}

multi sub l-dist( $a, "" ) { $a.codes }
multi sub l-dist( "", $a ) { $a.codes }
multi sub l-dist( $a, $b where $a ~~ $b ) { 0 }
multi sub l-dist( $a, $b ) {
    my ($ah, $ar) = first( $a );
    my ($bh, $br) = first( $b );
    if ( $ah ~~ $bh ) {
        return l-dist( $ar, $br );
    } else {
        return 1 + min(
            l-dist( "$ah$ar", $br ),
            l-dist( $ar, "$bh$br" ),
            l-dist( $ar, $br ),
        );
    }
}

sub first( $a ) {
    ( $a.substr(0,1), $a.substr(1,*) );
}
