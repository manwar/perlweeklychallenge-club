#!/usr/bin/env perl6
use v6;

sub partw($w,@a,@acc) {
    $w eq '' && return @acc;
    @a.map({ $w.starts-with($_) && (partw($w.substr($_.chars),@a,(|@acc,$_))) })
    .grep( *.so )
}

partw(@*ARGS[0],@*ARGS[1..*],())
.map(*.flat)
.say

# run as <script> <target word> <array of space-separated words>

