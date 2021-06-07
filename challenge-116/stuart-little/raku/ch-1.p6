#!/usr/bin/env perl6
use v6;

# run <script> <number>

sub consecSplit(Str $s) {
    return (1..$s.chars).map({ $s.substr(0,$_) }).map({ (0..$s.chars).map(-> $i { $_.Int + $i }) }).map(-> @a {(0..^@a.elems).map(-> $ix {@a.[0..$ix]})}).map(-> @aa {@aa.first({ $_.join("").chars >= $s.chars })}).first({ $_.join("") eq $s })
}

consecSplit(@*ARGS[0]).say
