#!raku

#
# Perl Weekly Challenge 320
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-320>
#

sub MAIN( *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems }) {
    ( @numbers.grep( *.Int <= 0 ).elems, @numbers.grep( *.Int >= 0 ).elems ).max.say;
}
