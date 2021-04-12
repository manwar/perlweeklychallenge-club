#!raku


multi sub triangles( 0 ) { return 1; }
multi sub triangles( 1 ) { return 1; }
multi sub triangles( Int $base where { $base > 1 }, @triangle ) {
    # since $base starts from 2, the previous row is
    # 0, so $base - 2
    my @previous-row = | @triangle[ $base - 2 ];

    # add the leftmost element of this row
    my @current-row.push: @previous-row.tail;

    # iterate and compute the diagonal sum
    for 1 ..^ $base {
        @current-row.push: ( @previous-row[ $_ - 1 ] + @current-row[ $_ - 1 ] );
    }

    return @current-row;
}


sub MAIN( Int :$base = 15 ) {

    # initialize the array used to compute Bell Numbers
    my @triangle = triangles( 1 );

    # compute all the triangle rows up to the base
    @triangle.push: triangles( $_, @triangle ) for 2 .. $base;

    # extract all the leftmost numbers of every row
    my @bell-numbers.push:  @triangle[ $_ ].head for 0 ..^ @triangle.elems;

    # all done, print out
    say "$base first Bell Numbers:";
    @bell-numbers.join( "\n" ).say;
}
