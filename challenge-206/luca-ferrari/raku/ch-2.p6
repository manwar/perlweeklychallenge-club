#!raku

#
# Perl Weekly Challenge 206
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-206/>
#

sub MAIN( *@list where { @list.elems %% 2 && @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my @sums;

    for @list.permutations {
	for $_.rotor( 2 ) -> $a, $b {
	    @sums.push: sum( min( $a ) + min( $b ) );
	}
    }

    @sums.min.say;
}
