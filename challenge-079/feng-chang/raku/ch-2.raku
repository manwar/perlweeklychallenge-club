#!/bin/env raku

sub trapped-drops(@N) returns UInt {
    my UInt $cnt;

    repeat {
        @N.shift while @N.elems > 0 and @N[0]   ≤ 0;
        @N.pop   while @N.elems > 0 and @N[*-1] ≤ 0;
        last if @N.elems < 3;

        my $height = min(@N[0, *-1]);
        for 0..^@N.elems -> $i {
            my $drop = max(0, $height - @N[$i]);
            $cnt   += $drop;
            @N[$i] += $drop - $height;
        }
    } while @N.elems > 2;

    $cnt;
}

say trapped-drops(Array.new(2, 1, 4, 1, 2, 5));
say trapped-drops(Array.new(3, 1, 3, 1, 1, 5));
