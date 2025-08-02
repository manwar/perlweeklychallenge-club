#!raku

#
# Perl Weekly Challenge 322
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
#

sub MAIN( Str $string, Int $size where { $size <= $string.chars } ) {
    $string.split( '-' ).join.flip.comb( :skip-empty ).rotor( $size, :partial ).map( *.join ).join( '-' ).flip.say;
}
