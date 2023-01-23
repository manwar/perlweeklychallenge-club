#!raku

#
# Perl Weekly Challenge 201
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-201/>
#

sub MAIN( *@n where { @n.grep( * ~~ Int ) == @n.elems } ) {
    my @missing-numbers;
    for 0 ^.. @n.elems {
	@missing-numbers.push: $_ if ( ! @n.grep( $_ ) );
    }

    @missing-numbers.join( ', ' ).say;

}
