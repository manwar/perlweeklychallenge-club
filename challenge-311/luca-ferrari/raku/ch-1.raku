#!raku

#
# Perl Weekly Challenge 311
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-311>
#

sub MAIN( Str $string ) {
    $string.comb.map( { $_ ~~ /<[A..Z]>/ ?? $_.lc !! $_.uc } ).join.say;
}
