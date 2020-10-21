#!/usr/bin/env raku

sub words-length (Str $s) {
    my @w = $s.trim.indices(' ');
    return @w.elems == 0 ?? 0 !! @w.tail - @w.head - @w.elems + 1;
}

say words-length @*ARGS[0];
