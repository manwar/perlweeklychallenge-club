#!/bin/env raku

unit sub MAIN(*@ints);

put delete-and-earn(@ints);

sub delete-and-earn(*@ints --> UInt:D) {
    given +@ints {
        when 0  { 0 }
        default {
            (^+@ints).map(-> $i {
                my $n = @ints[$i];
                $n + delete-and-earn(@ints[0..^$i, $i^..*-1].flat.grep(* != ($n-1)|($n+1)))
            }).max
        }
    }
}
