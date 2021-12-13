#!raku

sub MAIN( Int $n where { $n > 0 } ) {
    my @numbers = 1 ^..^ $n;

    # extract all the pairs to get the $n by multiplication
    my @pairs = @numbers.grep( $n %% * ).map( { $_, $n / $_, $_ + $n / $_ } );

    # now extract all the pairs couples that have a difference of one
    for 0 ..^ @pairs.elems -> $left {
        for $left ^..^ @pairs.elems -> $right {
            "$n is stealth by { @pairs[ $left ][ 0..1 ].join( ',' ) } and { @pairs[ $right ][ 0..1 ].join( ',' ) }".say  if @pairs[ $left ][ 2 ] - @pairs[ $right ][ 2 ] == any( 1, -1 );
        }
    }

}
