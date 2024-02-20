#!raku

#
# Perl Weekly Challenge 257
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
#

sub MAIN( *@numbers where { @numbers.elems == @numbers.grep( * ~~ Int ).elems } ) {
    @numbers.map( -> $current { @numbers.grep( * < $current ).elems } ).join( ', ' ).say;
}
