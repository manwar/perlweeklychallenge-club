#!/usr/bin/env raku

say (^Inf).hyper.grep({$_ == sum .comb Z** 1.. .chars}).head(19);
