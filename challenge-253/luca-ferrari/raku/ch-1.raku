#!raku

#
# Perl Weekly Challenge 253
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
#

sub MAIN( $separator, *@words ) {
    @words.split( $separator, :skip-empty ).join( ',' ).say;
}
