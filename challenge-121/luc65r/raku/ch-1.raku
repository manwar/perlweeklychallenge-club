#!/usr/bin/env raku

unit sub MAIN(UInt $m, UInt $n is copy where * > 0);

say $m +^ 1 +< ($n - 1);
