#!/usr/bin/env perl6
use v6;

# This is the first one where I wrote a P5 solution before the P6 solution.
#
# It's also the only time the P6 output differs from the P5 output,
# although both meet the requirement of the challenge.
#
# Difference: Perl 6 IO.words splits differently than Perl 5 split /\W+/

sub MAIN(+@files) {
    my %docs;

    # Read the files, seperating out the words.  Sadly no parallelism
    # here, I don't have a Perl6 module for doing simultanious file
    # reads of large files.  :(
    for @files -> $fn {
        %docs{$fn} = $fn.IO.words.unique;
    }

    # Build the index
    my %index;
    for %docs.keys.sort -> $fn {
        for @(%docs{$fn}) -> $word {
            %index{$word} = [] unless %index{$word}:exists;
            %index{$word}.push: $fn;
        }
    }

    # Output the index
    for %index.keys.sort -> $word {
        say "$word: { %index{$word}.join(" ") }";
    }
}


