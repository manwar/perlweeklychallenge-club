#!raku

#
# Perl Weekly Challenge 273
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
#

sub MAIN( Str $string where { $string.chars > 0 } ) {
    'True'.say and exit if ( $string ~~ / b / && $string !~~ / b .* a / );
    'False'.say;

}
