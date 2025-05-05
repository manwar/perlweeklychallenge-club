#!/bin/env raku

unit sub MAIN(*@ints where .all > 0);

put abs(@ints.sum - @ints».comb.flat(:hammer).sum);
