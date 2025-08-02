#!raku

#
# Perl Weekly Challenge 260
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
#

sub MAIN( $word ) {
    say $word.comb.permutations.map( *.join ).sort.grep( * ~~ $word, :k ).first + 1;
}
