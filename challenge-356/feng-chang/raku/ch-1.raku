#!/bin/env raku

unit sub MAIN(UInt:D $int);

put +kolakoski($int).grep(1);

sub kolakoski(UInt:D $n) {
    state @seq = 1, 2, 2;
    my $i = 2;
    my $val = 1;

    while +@seq < $n {
        @seq.append($val xx @seq[$i++]);
        $val = 3 - $val;
    }

    @seq[^$n]
}
