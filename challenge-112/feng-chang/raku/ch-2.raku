#!/bin/env raku

proto walk(UInt:D --> UInt:D) {*}   # restrict dispatch pattern

multi walk(0)  { 1 }
multi walk(1)  { 1 }
multi walk(2)  { 2 }

multi walk($n) {
    state @memo;                    # use memory to speed up counting
    @memo[$n] = walk($n-1) + walk($n-2) unless @memo[$n].defined;
    @memo[$n];
}

sub MAIN(UInt:D $n) { put walk($n) }
