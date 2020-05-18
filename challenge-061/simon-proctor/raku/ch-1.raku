#!/usr/bin/env raku

use v6;

sub MAIN ( *@values ) {
    sub-lists( @values ).sort( -> $l { [*] @$l } ).reverse.first.say;
}

sub sub-lists( @list ) {
    gather {
        for ^@list -> $start {
            for $start..^@list -> $end {
                take @list[$start..$end];
            }
        }
    }
}
