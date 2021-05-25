#!/bin/env raku

sub MAIN(UInt:D $n) {
    put (1, 1, *+* ... *)[$n];      # It's Fibonacci!
}
