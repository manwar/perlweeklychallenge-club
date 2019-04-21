#!/usr/bin/env perl6 -n

# run as "ch-2a.p6 words.txt"

my %letters = bag <n n a a a b p e p l>;

my %counter = %letters;
goto NextWord unless %counter{$_}-- for .comb;
.say;

NextWord:
# goto not yet implemented
# I'd like to "next" up to the -n next line.



