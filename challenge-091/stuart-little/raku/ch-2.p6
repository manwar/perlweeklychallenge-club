#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated array>

sub jumpp(@a where *.all >= 0) {
    @a[0] >= @a.elems-1 && return True;
    @a[0] == 0 && return False;
    return jumpp(@a[@a[0]..*]);
}

say @*ARGS.&jumpp.Int
