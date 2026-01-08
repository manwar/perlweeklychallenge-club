#!raku

#
# Perl Weekly Challenge 355
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-355>
#



sub MAIN( Int $number ) {
    $number.Str.flip.comb.rotor( 3, :partial ).map( *.join ).join( '.' ).flip.say;
}
