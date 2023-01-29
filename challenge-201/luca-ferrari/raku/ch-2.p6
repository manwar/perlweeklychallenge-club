#!raku

#
# Perl Weekly Challenge 201
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-201/>
#

use Math::Combinatorics <partitions>;

sub MAIN( Int $n where { $n > 0 } ) {
    say partitions( $n ).elems;
}
