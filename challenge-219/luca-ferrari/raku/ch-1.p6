#!raku

#
# Perl Weekly Challenge 219
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-219/>
#

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems } ) {
    @n.map( { $_ ** 2 } ).sort.join( ', ' ).say;
}
