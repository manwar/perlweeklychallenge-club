#!raku

#
# Perl Weekly Challenge 325
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
#

sub MAIN( *@prices where { @prices.grep( * ~~ Int ).elems == @prices.elems } ) {
    my @final-prices;
    for 0 ..^ @prices.elems -> $index {
	@final-prices.push: @prices[ $index ] - ( @prices[ $index + 1 .. * ].grep( * < @prices[ $index ] )[ 0 ] // 0 );
    }

    @final-prices.join( ', ' ).say;
}
