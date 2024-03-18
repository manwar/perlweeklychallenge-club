#!/usr/bin/env raku
use Test;

is multiply-by-two([5,3,6,1,12], 3), 24;
is multiply-by-two([1,2,4,3], 1),     8;
is multiply-by-two([5,6,7], 2),       2;

multi multiply-by-two(@i, $s)                    { return $s            }
multi multiply-by-two(@i, $s where $s (elem) @i) { samewith(@i, $s * 2) }
