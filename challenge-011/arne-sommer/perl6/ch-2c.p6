#! /usr/bin/env perl6

unit sub MAIN (Int $size where $size > 0);

my @im[$size;$size] = 0 xx $size xx $size;

@im[$_;$_] = 1 for ^$size;

say @im;

