#!raku

# Perl Weekly Challenge 192

sub MAIN( *@n is copy where { @n.elems == @n.grep( * ~~ Int ).elems }
	, :$verbose = False ) {
    my $elem = @n.sum / @n.elems;
    '-1'.say and exit if ( $elem.Int !~~ $elem );

    my @moves;
    @moves.push: [@n];
    while ( @n.grep( * ~~ $elem ).elems != @n.elems ) {
	for 0 ..^ @n.elems -> $index {
	    if ( @n[ $index ] == @n.max ) {
		for 0 ..^ @n.elems -> $borrow {
		    next if $borrow == $index;
		    next if @n[ $borrow ] >= @n[ $index ];
		    next if @n[ $borrow ] >= $elem;
		    @n[ $borrow ]++;
		    last;
		}

		@n[ $index ]--;
	    }

	}

	@moves.push: [@n];
    }


    @moves.join( "\n" ).say if $verbose;
    @moves.elems.say;
}
