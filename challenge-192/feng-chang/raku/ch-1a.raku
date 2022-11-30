#!/bin/env raku

unit sub MAIN(UInt:D \N);

put ('1' x N.base(2).chars).parse-base(2) - N;
