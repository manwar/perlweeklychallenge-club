#!raku

#
# Perl Weekly Challenge 353
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
#

sub MAIN( *@sentences ) {
    @sentences.map( *.split( /\s+/ ).elems ).max.say;
}
