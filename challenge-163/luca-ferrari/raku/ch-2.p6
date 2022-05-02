#!raku

# Perl Weekly Challenge 163

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems } ) {

    my @matrix;
    @matrix.push: [ @n ];

    while ( @matrix[ * - 1 ].elems > 2 ) {
        my @row;
        @row.push: @matrix[ * - 1 ][ 1 ] ;

        for 2 ..^ @matrix[ * - 1 ].elems {
            @row.push: @matrix[ * - 1 ][ $_ ] + @row[ * - 1 ];
        }

        @matrix.push: [ @row ];
    }

    @matrix.push: [ @matrix[ * - 1 ][ * - 1 ] ];

    say @matrix[ * - 1 ][ 0 ];
}
