#!raku

#
# Perl Weekly Challenge 369
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
#

sub MAIN( Str $title ) {
    my @tags;

    for $title.lc.split( / \s+ / ) -> $word {
        next if $word !~~ / ^ <[a..z A..Z - ]>+ $ /;
        my @letters = $word.comb.Array;
        @letters[ 0 ] .= uc;
        @tags.push: @letters.join;
    }

    say '#' ~ @tags.join;
}
