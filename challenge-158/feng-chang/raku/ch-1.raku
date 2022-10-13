#!/bin/env raku

unit sub MAIN(UInt:D \N = 100);

put (^N).grep(*.is-prime).grep(*.comb.sum.is-prime).join(', ');
