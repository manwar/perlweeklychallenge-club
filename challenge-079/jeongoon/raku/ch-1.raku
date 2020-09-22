#!/usr/bin/env raku
# -*- Mode: Raku -*-

use v6.d;
our &MAIN=&say∘(*%1000000007)∘&sum∘(*.map(*.base(2).comb.grep(1).elems))∘(->$e {1..$e});
