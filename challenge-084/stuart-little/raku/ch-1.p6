#!/usr/bin/env perl6

sub rev(Int $nr) {
    return ($nr >= 2**31) ?? (0)
    !! ($nr.sign.chop ~ $nr.abs.flip);
}

say rev(@*ARGS[0].Int);
