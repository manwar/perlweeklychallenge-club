#!raku

#
# Perl Weekly Challenge 332
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
#

sub MAIN( Str $date where { $date ~~ / ^ \d ** 4 '-' \d ** 2 '-' \d ** 2 $/ } ) {
    my @bins;
    for $date.split( '-' ) {
	@bins.push: $_.Int.base( 2 );
    }

    @bins.join( '-' ).say;
}
