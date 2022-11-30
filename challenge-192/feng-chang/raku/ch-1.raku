#!/bin/env raku

unit sub MAIN(UInt:D \N);

put N.base(2).comb.map(1-*).join.parse-base(2);
