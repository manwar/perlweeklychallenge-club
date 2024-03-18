#!/usr/bin/env raku
use Test;

is multiply-by-two([5,3,6,1,12], 3), 24;
is multiply-by-two([1,2,4,3], 1),     8;
is multiply-by-two([5,6,7], 2),       2;

multi multiply-by-two(@i, $s)               { samewith(@i.BagHash, $s)               }
multi multiply-by-two($b, $s)               { return $s                              }
multi multiply-by-two($b, $s where ?$b{$s}) { $b{(0..$s)}:delete; samewith($b, $s*2) }
