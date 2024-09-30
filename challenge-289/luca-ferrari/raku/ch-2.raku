#!raku

#
# Perl Weekly Challenge 289
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
#

sub MAIN( *@words ) {
    my @output;
    for @words -> $current_word  {
	my @letters = $current_word.comb( :skip-empty );
	my ( $index_first, $index_last ) = 0, @letters.elems - 1;
	while ( @letters[ $index_last ] !~~ /<[a .. z A .. Z 0 .. 9 ]>/ ) {
	    $index_last--;
	}

	my $new_word = ( @letters[ $index_first ],
			 @letters[ $index_first + 1 .. $index_last - 1 ].pick( $index_last - $index_first ).join( '' ),
			 @letters[ $index_last ],
			 @letters[ $index_last + 1 .. * - 1 ] ).join( '' );

	@output.push: $new_word;
    }

    @output.join( ' ' ).say;
}
