#!/usr/bin/env raku
use v6;
sub MAIN (Str $s = '1ac2.34f0.b1c2') { put MAC-address($s) }
sub MAC-address ($x) { $x.comb(rx:i/<[ a..f 0..9 ]> ** 2/).join(':') }
