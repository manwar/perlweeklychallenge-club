#!/usr/bin/env perl6

my &idm = -> $size { gather for ^$size -> $y { take map { Int($_ == $y) }, ^$size } };
.join(' ').say for idm(4); # 4... 2... 16... or whatever...

