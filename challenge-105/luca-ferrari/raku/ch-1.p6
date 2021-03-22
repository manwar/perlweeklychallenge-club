#!raku

sub MAIN( Int $N = 5, Int $K = 248832 ) {
    "Computing $N root of $K".say;
    "%.2f".sprintf( .re ).say given $K.roots( $N ).grep( { ! .im.Int } )[ 0 ];
}
