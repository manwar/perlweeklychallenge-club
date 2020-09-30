#!/bin/env raku

for 1..∞ -> UInt $i {
    { say $i; last; } unless @*ARGS.grep: * == $i;
    #{ say $i; last; } unless $i (elem) @*ARGS.Set;
}
