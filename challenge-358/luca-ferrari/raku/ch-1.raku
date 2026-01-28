#!raku

#
# Perl Weekly Challenge 358
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
#

sub MAIN( *@strings ) {
    @strings.map( { $_ ~~ / ^ <[0 .. 9]>+ $ / ?? $_.Int !! $_.chars } ).max.say;
}
