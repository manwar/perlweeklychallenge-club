#!raku

# Perl Weekly Challenge 197

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my @sorted = @list;
    my $done = False;

    #  list[0] < list[1] > list[2] < list[3]….
    while ( ! $done ) {
	$done = True;
	for 0 ..^ @sorted.elems - 1 -> $i {
	    if ( $i %% 2 ) {
		if ( @sorted[ $i ] >= @sorted[ $i + 1 ] ) {
		    # need to change
		    my $temp = @sorted[ $i ];
		    @sorted[ $i ] = @sorted[ $i + 1 ];
		    @sorted[ $i + 1 ] = $temp;
		    $done = False;
		}
	    }
	    else {
		if ( @sorted[ $i ] <= @sorted[ $i + 1 ] ) {
		    # need to change
		    my $temp = @sorted[ $i ];
		    @sorted[ $i ] = @sorted[ $i + 1 ];
		    @sorted[ $i + 1 ] = $temp;
		    $done = False;

		}
	    }

	}
    }

    @list.join( ',' ).say;
    @sorted.join(',').say;
}
