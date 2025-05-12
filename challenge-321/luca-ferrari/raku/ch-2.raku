#!raku

#
# Perl Weekly Challenge 321
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
#

sub MAIN( Str $left, Str $right ) {
    say $left.subst( / . <[#]> /, '', :g ) ~~ $right.subst( / . <[#]> /, '', :g );
}
