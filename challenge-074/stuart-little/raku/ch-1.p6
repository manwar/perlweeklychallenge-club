#!/usr/bin/env perl6
use v6;

sub maj(@a) {
    @a.grep({ @a.grep($_).elems > floor(@a/2) }).[0] || -1
}

say maj(@*ARGS);

# run as <script> <space-separated integers>
