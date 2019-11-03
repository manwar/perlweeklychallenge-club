#!/usr/bin/env perl6
use v6;

sub MAIN(+@filenames, Bool :$csv) {
    # Assumption: no line is blank.
    # Assumption: Files will fit into RAM simultaniously

    @filenames.push("example.txt") unless @filenames.elems;

    my @words;
    for @filenames -> $fn {
        @words.push: | $fn.IO.lines.grep( * ne '' );
    }
    my $bag = bag @words;
    my $sorted = $bag.pairs.sort( { $^a.value <=> $^b.value } ).reverse;

    if $csv {
        say $sorted.map( { "{$_.key},{$_.value}" } ).join("\n");
    } else {
        say $sorted.map( { "{$_.key}\t{$_.value}" } ).join("\n");
    }
}


