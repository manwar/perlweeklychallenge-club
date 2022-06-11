#!/usr/bin/env raku

(2..100).grep(&is-prime).grep(*.comb.sum.is-prime).join(', ').say;
