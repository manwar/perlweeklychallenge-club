#!raku

#
# Perl Weekly Challenge 211
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-211/>
#

sub MAIN( *@list where{ @list.elems == @list.grep( * ~~ Int ).elems } ) {

    for @list.permutations -> @current {
	for 0 ..^ @current.elems {
	    my ($left, $right) = @current[ 0 .. $_ ], @current[ $_ + 1 .. * - 1 ];
	    if ( ( $left.sum / $left.elems ) == ( $right.sum / $right.elems ) ) {
		exit;
	    }
	}
    }
}
