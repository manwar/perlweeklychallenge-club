#! /usr/bin/env perl6

unit sub MAIN (Int $size where $size > 0);

my @row = (1, 0 xx $size -1).flat;
my @x; @x.push: @row.rotate(- $_) for ^$size;
my @im[$size;$size] =  @x;

say @im;

