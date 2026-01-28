#!raku

#
# Perl Weekly Challenge 358
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
#

sub MAIN( Str $string, Int $value ) {
    my @alphabet = 'a' .. 'z';

    $string.lc.comb.map( -> $me { @alphabet[ ( $value + @alphabet.grep( * ~~ $me, :k ).first ) % @alphabet.elems ]  } ).join.say;

}
