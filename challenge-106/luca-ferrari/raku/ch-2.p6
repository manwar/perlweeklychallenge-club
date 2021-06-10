#!raku

sub MAIN( Int $D, Int $N where { $N != 0 } ) {
    my @values = ( $D / $N ).base-repeating( 10 );

    @values[ 0 ].say and exit if ( ! @values[  1 ] );
    '%s(%s)'.sprintf( @values ).say;
}
