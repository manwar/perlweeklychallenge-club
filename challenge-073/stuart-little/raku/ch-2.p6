#!/usr/bin/env perl6
use v6;

sub slide(@a) {
    (0..^@a).map({ (@a.[0..$_].min < @a[$_]) ?? (@a[0..^$_].min) !! (0) })
}

say slide(@*ARGS.map(*.Int));

# run as <script> <space-separated array entries>
