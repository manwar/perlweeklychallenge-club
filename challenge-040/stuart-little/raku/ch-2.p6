#!/usr/bin/env perl6
use v6;

sub selord(@a,@i) {
    (|(@i Z=> @a.pairs.grep(*.key == @i.any).sort(*.value).map(*.value)), |@a.pairs.grep(*.key !== @i.any))
    .sort(*.key)
    .map(*.value)
}

say selord(@*ARGS[0].split(',').map(*.Int), @*ARGS[1].split(',').map(*.Int))

# run as <script> <comma-separated entries of array> <comma-separated indices>, with the two strings separated by whitespace
# e.g. <script>  10,4,1,8,12,3  0,2,5
