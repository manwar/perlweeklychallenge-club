#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated ordered interval endpoints, with the interval to be inserted coming first>

sub endpts(@a) {
    (@a (-) @a.map(*+1)).keys.sort Z (@a.map(*+1) (-) @a).keys.sort
}

say @*ARGS.map(*.Int).Hash.map({ $_.key.Int ..^ $_.value }).reduce(&infix:<(+)>).Set.keys.sort.&endpts
