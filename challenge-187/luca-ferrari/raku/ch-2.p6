#!raku

# Perl Weekly Challenge 187

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems } ) {

    my $max = 0;
    my @triplet;
    for 0 ..^ @n.elems -> $index-a {
    	my $a = @n[ $index-a ].Int;

	for $index-a ^..^ @n.elems -> $index-b {
	    my $b = @n[ $index-b ].Int;

	    for $index-b ^..^ @n.elems -> $index-c {
	    	my $c = @n[ $index-c ].Int;

		if ( $max <= $a + $b + $c
		     && ( $a + $b ) > $c
		     && ( $b + $c ) > $a
		     && ( $a + $c ) > $b ) {
		     @triplet = $a, $b, $c;
		     $max = $a + $b + $c;
		}
	    }
	}
    }

    @triplet.sort.say if ( @triplet );
}
