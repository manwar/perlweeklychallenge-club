#!raku


sub MAIN( Int $N where { $N > 0 } ) {
    say $_ and exit if ( $N.base( 2 ).split( '' ).grep( '1' ).elems == $_.base( 2 ).split( '' ).grep( '1' ).elems ) for $N ^.. Inf;

}
