#!/usr/bin/env perl6
use v6;

sub MAIN(+@words) {
    my $matches = [∩] @words.map( { substrings($^a) } );
    my @matchwords = $matches.keys.list;

    if @matchwords.elems {
        my $max = max @matchwords».chars;
        my @longwords = @matchwords.grep: { $^a.chars == $max };
        say "Max length: $max; Substrings: " ~ @longwords.join(" ");
    } else {
        say "No substrings in common";
    }
}

sub substrings(Str() $word -->Set) {
    my @chars = $word.comb;
    
    return set gather {
        for ^(@chars.elems) -> $i {
            for $i .. (@chars.elems - 1) -> $j {
                take @chars[$i .. $j].join;
            }
        }
    }
}


