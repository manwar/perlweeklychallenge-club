#!raku

#
# Perl Weekly Challenge 273
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
#

sub MAIN( Str $string, Str $char where { $char.chars == 1 } ) {
    ( $string.comb.grep( * ~~ $char ).elems / $string.comb.elems * 100 ).Rat.round.say;
}
