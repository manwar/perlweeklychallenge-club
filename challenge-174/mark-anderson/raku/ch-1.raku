#!/usr/bin/env raku

say (^Inf).hyper.grep({ $_ == [+] .comb Z** 1..* }).head(19);
