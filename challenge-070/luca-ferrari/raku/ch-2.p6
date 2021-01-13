#!raku


sub MAIN( Int $N where { 2 <= $N <= 5 } ) {
    say "Grey sequence with width $N";

    my @sequence;
    @sequence[ 0 ] = 0.base( 2 );
    @sequence[ 1 ] = 1.base( 2 );

    for 2 .. $N {
        # duplicate the sequence
        @sequence.push: | @sequence.reverse;

        # add the zero or one to the elements
        for 0 ..^ @sequence.elems -> $mirroring {
            @sequence[ $mirroring ] = ( $mirroring >= @sequence.elems / 2 ?? '1' !! '0' ) ~ @sequence[ $mirroring ];
        }

    }

    @sequence.map( *.parse-base( 2 ) ).say;
}
