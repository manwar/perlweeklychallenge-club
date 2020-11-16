#!/usr/bin/env perl6
use v6;

sub pws(Int $n) {
    (2..$n.sqrt).grep({ $_ ** log($n,$_).Int == $n }).map({ $_, log($n,$_) })
}

say (@*ARGS[0].Int.&pws) ?? ("$_[0]^$_[1]" for |@*ARGS[0].Int.&pws) !! 0

# run as <script> <number>
