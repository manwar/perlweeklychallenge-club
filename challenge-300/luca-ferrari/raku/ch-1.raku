#!raku

#
# Perl Weekly Challenge 300
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-300>
#

sub MAIN( Int $n, Bool :$verbose  where { $n >= 1 } = False ) {

    my @beautifuls;
    for ( 1 .. $n ).permutations -> $current-permutation {
	my $is-beautiful = True;

	for 0 ..^ $current-permutation.elems {
	    my ( $index, $value ) = $_ + 1, $current-permutation[ $_ ];
	    if ( ! ( $value %% $index ) && ! ( $index %% $value ) ) {
		$is-beautiful = False;
		last;
	    }

	}

	@beautifuls.push: $current-permutation if ( $is-beautiful );
    }

    @beautifuls.elems.say;
    @beautifuls.say if ( $verbose );
}
