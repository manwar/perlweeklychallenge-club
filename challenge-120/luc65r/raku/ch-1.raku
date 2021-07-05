#!/usr/bin/env raku

unit sub MAIN(UInt:D $n where * < 256);

say $n +& 0x55 +< 1 +| $n +& 0xAA +> 1;
