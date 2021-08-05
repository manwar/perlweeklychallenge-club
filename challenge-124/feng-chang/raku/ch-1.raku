#!/bin/env raku

for '14322222341000100'.comb».UInt -> $c {
    given $c {
        when 0  { put '     ^' }
        when 1  { put '   ^^^^^' }
        default { put ' ' x ($c - 2), '^', ' ' x (13 - $c * 2), '^' }
    }
}
