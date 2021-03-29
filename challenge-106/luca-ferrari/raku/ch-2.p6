#!raku

sub MAIN( Int $D, Int $N where { $N != 0 } ) {
    my @values = ( $D / $N ).base-repeating( 10 );

    print @values[ 0 ];
    print '(%s)'.sprintf: @values[ 1 ] if ( @values[ 1 ] );
    put '';
}
