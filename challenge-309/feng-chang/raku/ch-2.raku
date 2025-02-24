#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.combinations(2).map({ ([-] $_).abs }).min;
