#!raku

#
# Perl Weekly Challenge 234
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-234/>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my @triples;

    #(i, j, k) that satisfies num[i] != num[j], num[j] != num[k] and num[k] != num[i].
    for 0 ..^ @nums.elems - 2  -> $i {
	for $i ^..^ @nums.elems - 1 -> $j {
	    for $j ^..^ @nums.elems -> $k {
		@triples.push: [ $i, $j, $k ] if ( @nums[ $i ] != @nums[ $j ]
						   && @nums[ $j ] != @nums[ $k ]
						   && @nums[ $k ] != @nums[ $i ] );
	    }
	}
    }

    @triples.join( "\n" ).say;
}
