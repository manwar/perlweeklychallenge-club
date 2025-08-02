sub MAIN( :@left, :@right ) {
    my %left-bag  = Bag.new( @left );
    my %right-bag = Bag.new( @right );
    my @matches;
    my @single-left  = %left-bag.kv.grep( -> $k, $v { $v == 1 } ).map( *[ 0 ] );
    my @single-right = %right-bag.kv.grep( -> $k, $v { $v == 1 } ).map( *[ 0 ] );
    for @single-left -> $left {
    	@matches.push( $left ) if ( @single-right.grep( * ~~ $left ) );
    }

    @matches.elems.say;
}
