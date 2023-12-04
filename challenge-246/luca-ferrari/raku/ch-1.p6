#!raku

#
# Perl Weekly Challenge 246
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
#

sub MAIN() {

    my @lottery;
    while ( @lottery.elems < 6 ) {
	@lottery.push: $_ if ( ! @lottery.grep( $_ ) ) given ( 49.rand.Int );
    }

    @lottery.join( "\n" ).say;
}
