sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    #     A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y).
    my @strong;
    for 0 ..^ @nums.elems - 1 -> $i {
    	for $i ^..^ @nums.elems -> $j {
        @strong.push: [ @nums[ $i ], @nums[ $j ] ] if ( 0 < abs( @nums[ $i ] - @nums[ $j ] )  < min( @nums[ $i ], @nums[ $j ] ) );
    	}
    }

    @strong.elems.say;
}
