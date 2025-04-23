#!raku

#
# Perl Weekly Challenge 318
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-318>
#

sub MAIN( :@a, :@b) {

    for 0 ^..^ @a.elems {
	'True'.say and exit if ( @a[ 0 .. $_ ].reverse, @a[ $_ + 1 .. * - 1 ] ).flat ~~ @b;
    }

    'False'.say;
}
