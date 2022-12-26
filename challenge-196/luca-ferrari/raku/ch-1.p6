#!raku

# Perl Weekly Challenge 196

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } )  {
    my @found;
    my $last = 0;

    for @list.rotor( 3, :partial ) -> $triplet {
	next if $triplet.elems != 3;
	@found.push: $triplet if ( $triplet[ 0 ] < $triplet[ 1 ] < $triplet[ 2 ] );
    }

    @found.join( "\n" ).say;
}
