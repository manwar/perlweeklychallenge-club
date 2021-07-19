#!/usr/bin/env raku
use v6;
subset IntByte of Int where 0 <= * <= 255;
subset BitNum  of Int where 1 <= * <= 8;
sub invert-bit (IntByte:D $m, BitNum:D $n) { $m +^ (1 +< ($n - 1)) }

put "m=12 n=3 -> " ~ invert-bit(12, 3);
put "m=18 n=4 -> " ~ invert-bit(18, 4);
