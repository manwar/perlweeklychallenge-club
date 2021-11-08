#!/bin/env raku

sub MAIN(UInt:D $N where * ≥ 10) {
    for 1 .. $N.chars div 2 -> $len {
        my $n = $N;
        my $i = $n.substr(0, $len);
        while $n.chars > 0 {
            last unless $n.substr(0, $i.chars) eq $i;
            $n .= substr($i.chars);
            ++$i;
        }
        if $n.chars == 0 {
            put 1;
            exit;
        }
    }
    put 0;
}
