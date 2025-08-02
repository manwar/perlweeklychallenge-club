#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.comb(/\d+/).unique;
