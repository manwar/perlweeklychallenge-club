#!/bin/env raku

unit sub MAIN(*@ints where .all > 0);

put @ints.sum - @ints».comb.flat(:hammer).sum;
