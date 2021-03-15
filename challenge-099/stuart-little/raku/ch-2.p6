#!/usr/bin/env perl6
use v6;

# run <script> <string1> <string2>

sub counts(@ambient, @small)  {
    (! @small) && return 1;
    (! @ambient) && return 0;    
    return (0..^@ambient.elems).grep({ @ambient.[$_] === @small.head }).map({ @ambient[$_^..^@ambient.elems] }).map({ counts($_,@small[1..*]) }).sum
}

say counts(@*ARGS[0].comb, @*ARGS[1].comb)
