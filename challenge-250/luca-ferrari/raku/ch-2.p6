#!raku

#
# Perl Weekly Challenge 250
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
#

sub MAIN( *@words ) {
    @words.map( { $_ ~~ / ^ <[0..9]>+ $ / ?? $_.Int !! $_.chars } ).max.say;
}
