#!/usr/bin/env raku
# -*- Mode: Raku -*-
use v6.d;
# works only equal or less than 65535
our &MAIN=&say∘&sum∘(*.map(*.base(2).comb.grep(1).elems))∘(^(*+1));
