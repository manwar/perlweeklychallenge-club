#!/usr/bin/env perl6

# run as "ch-2.p6 words.txt"

my %letters = bag <n n a a a b p e p l>;

WORD:
for $*ARGFILES.words -> $word {
    my %counter = %letters;
    next WORD unless %counter{$_}-- for $word.comb;
    say $word;
}


