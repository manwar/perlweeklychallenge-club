#!/bin/env raku

unit sub MAIN(UInt:D $x is copy, UInt:D $y is copy);

my UInt $cnt = 0;
while $x and $y {
    $x ≥ $y ?? ($x -= $y) !! ($y -= $x);
    ++$cnt;
}

put $cnt;
