#!raku

#
# Perl Weekly Challenge 217
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-217/>
#

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems } ) {
    @n.sort()[ 3 ].say;
}
