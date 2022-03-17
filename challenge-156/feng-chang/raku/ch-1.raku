#!/bin/env raku

put (1..∞).grep(*.base(2).comb.sum.is-prime)[^10];
