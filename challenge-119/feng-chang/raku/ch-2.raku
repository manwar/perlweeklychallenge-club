#!/bin/env raku

sub MAIN(UInt:D $N where $N > 0) {
    my Seq $trin = gather for 1..∞ -> $i {
        my $n = $i.base(4);
        next if $n ~~ m/0/;
        next if $n ~~ m/11/;
        take $n;
    }

    put $trin[$N - 1];
}
