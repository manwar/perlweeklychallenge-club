#!raku

#
# Perl Weekly Challenge 287
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
#

sub MAIN( Str $number ) {
# - An integer number followed by an optional exponent.
# - A decimal number followed by an optional exponent.
    # - An integer number is defined with an optional sign '-' or '+' followed by digits.

    'False'.say and exit( 1 ) if ( $number !~~ / ^ <[+-]>? \d+ (.\d+)? (E<[+-]>?\d+)? $ / );
    'True'.say;

}
