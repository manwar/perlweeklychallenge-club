#!/usr/bin/env raku


(^Inf).grep(*.base(2).comb.sum.is-prime).head(10).say;