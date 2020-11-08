#!/usr/bin/env perl6
use v6;

sub flns($l1, $l2, $flnm) {
    $flnm.IO.lines[($l1-1,$l2-1).min..($l1-1,$l2-1).max].join("\n")
}

say flns(|@*ARGS[0,1].map(*.Int), @*ARGS[2]);

# run as <script> <two space-separated line numbers, in either order and then a filename>
