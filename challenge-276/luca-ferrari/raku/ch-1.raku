#!raku

#
# Perl Weekly Challenge 276
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
#

sub MAIN( *@hours where { @hours.elems == @hours.grep( * ~~ Int ) } ) {
    @hours.combinations( 2 ).grep( { ( $_[ 0 ] + $_[ 1 ] ) %% 24 } ).say;
}
