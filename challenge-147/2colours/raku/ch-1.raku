#!/usr/bin/env raku

use experimental :cached;

multi ltprimes(0, $) { ('') }
multi ltprimes($digits, $base) is cached {
  (1..^$base).map(*.base: $base) X~ ltprimes($digits-1, $base)
    andthen .grep(&is-prime)>>.Int
}


(1..*).map(*.&ltprimes(10).Slip).head(20).say;
