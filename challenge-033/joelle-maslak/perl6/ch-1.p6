#!/usr/bin/env perl6
use v6;

# We define letters as graphemes in any language supported by Raku that
# match the <alpha> class.  We display how many times each grapheme
# appears in the files.

sub MAIN(+@filenames) {
    my %letters;
    for @filenames -> $fn {
        my @chars = $fn.IO.lines.comb: /<alpha>/;
        for @chars -> $char {
            %letters{$char.fc}++;
        }
    }

    for %letters.keys.sort -> $key {
        say "$key: {%letters{$key}}";
    }
}


