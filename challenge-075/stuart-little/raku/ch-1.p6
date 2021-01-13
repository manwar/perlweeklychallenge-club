#!/usr/bin/env perl6
use v6;

sub coins($s, @c) {
    (! @c.grep(* <= $s)) && return ((),);
    return (|coins($s-@c[0], @c).map({ @c[0], |$_ }), |coins($s, @c[1..*])).grep(*.sum == $s);
}

for coins(@*ARGS[0].Int, @*ARGS[1..*].map(*.Int).sort) { .say};

# run as <script> <sum> <space-separated coin values>
