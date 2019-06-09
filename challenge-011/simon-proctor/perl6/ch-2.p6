#!/usr/bin/env perl6

use v6;

#| Output an indentity matrix of size N
sub MAIN ( UInt \N where * > 0 ) {
    (1..N).map( -> $i { (1..N).map( -> $j { $j == $i ?? 1 !! 0 }).join(" ") } ).join("\n").say;    
}