#!raku

#
# Perl Weekly Challenge 325
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
#

sub MAIN( *@bits where { @bits.grep( * ~~ / ^ <[01]>+ $ / ).elems == @bits.elems  } ) {

    ( @bits.join ~~ m:g/ 1+ / ).map( *.chars ).max.say;
}
