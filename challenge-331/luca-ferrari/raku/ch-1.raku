#!raku

#
# Perl Weekly Challenge 331
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
#

sub MAIN( Str $string ) {
    $string.split( /\s+/ ).grep( *.chars > 0 )[ * - 1 ].chars.say;
}
