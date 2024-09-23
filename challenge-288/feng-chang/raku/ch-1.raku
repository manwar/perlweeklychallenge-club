#!/bin/env raku

unit sub MAIN(UInt:D $int);

put min(
    ($int ^..  Inf).first({ $_ eq .flip }),
    ($int ^... 0  ).first({ $_ eq .flip }),
    :by({ abs($_ - $int), $_ })
);
