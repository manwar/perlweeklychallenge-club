#!/bin/env raku

unit sub MAIN(*@ints);

put (^+@ints).map({ seq-len($_) }).max;

sub seq-len(UInt:D $from is copy --> UInt:D) {
    my @seq;
    repeat {
        $from = @ints[$from];
        @seq.push($from);
    } until @seq.grep(@ints[$from]);

    +@seq
}
