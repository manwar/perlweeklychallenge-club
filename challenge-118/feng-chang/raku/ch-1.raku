#!/bin/env raku

sub MAIN(UInt:D $n) {
    my Str $s = $n.base(2);
    put +($s.flip eq $s);
}
