#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw( uniq );

my @examples = (

    [ "aba",  "aabb", "abcd", "bac", "aabc" ],
    [ "aabb", "ab",   "ba" ],
    [ "nba",  "cba",  "dba" ],
);

for my $e (@examples) {
    my @words  = $e->@*;
    my $words  = join ', ', map { qq{"$_"} } @words;
    my $output = similar_words(@words);
    say <<~"END";
    Input:  \@words = ($words)
    Output: $output
    END
}

sub similar_words (@words) {
    my @output;
    for my $i1 ( 0 .. -1 + scalar @words ) {
        my $w1 = $words[$i1];
        for my $i2 ( $i1 + 1 .. -1 + scalar @words ) {
            my $w2 = $words[$i2];
            next if $w1 eq $w2;
            my @l1 = uniq sort split //, $w1;
            my @l2 = uniq sort split //, $w2;
            my $k1 = join ' ', @l1;
            my $k2 = join ' ', @l2;
            push @output, join '/', sort $w1, $w2 if $k1 eq $k2;
        }
    }
    return scalar @output;
}
