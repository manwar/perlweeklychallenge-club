#!raku

#
# Perl Weekly Challenge 367
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-367>
#

sub MAIN( Str $binary where { $binary ~~ / ^ <[01]>+ $ / && $binary ~~ / 1+ / } ) {
    my ( $ones, $zeros ) = $binary.comb.grep( * ~~ 1 ).elems,
			   $binary.comb.grep( * ~~ 0 ).elems;
    $ones--;
    say '1' x $ones ~ '0' x $zeros ~ '1';
}
