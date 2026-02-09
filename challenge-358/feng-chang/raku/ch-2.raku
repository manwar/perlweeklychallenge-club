#!/bin/env raku

unit sub MAIN(Str:D $str, UInt:D $int);

put $str.comb.map({ ((.ord - 'a'.ord + $int) % 26 + 'a'.ord).chr }).join;
