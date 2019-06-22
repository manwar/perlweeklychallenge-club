#!/usr/bin/env perl6

use v6;

multi F(0) { 1 }
multi M(0) { 0 }

my (%F, %M);
multi F(UInt $n) { %F{$n} //= $n - M(F($n - 1)) }
multi M(UInt $n) { %M{$n} //= $n - F(M($n - 1)) }

unit sub MAIN (UInt $seqlength = 32);

say ('F:', |(^$seqlength).map: &F).join(' ');
say ('M:', |(^$seqlength).map: &M).join(' ');


