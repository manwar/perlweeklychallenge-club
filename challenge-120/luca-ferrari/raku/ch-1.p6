#!raku


sub MAIN( Int $N where { 0 < $N < 255 } ) {
    my @bits = '%08s'.sprintf( $N.base( 2 ) ).split( '', :skip-empty );

    my @rotated-bits;
    for my @bits -> $odd, $even {
        @rotated-bits.push: $even, $odd;
    }


    @rotated-bits.join.Str.parse-base( 2 ).say;
}
