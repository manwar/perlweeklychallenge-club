#!/usr/bin/env raku
use Test;

is order-game(2,1,4,5,6,3,0,2),                 1;
is order-game(0,5,3,2),                         0;
is order-game(9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8), 2;

multi order-game(+[$a,$b]) { min($a,$b) }
multi order-game(+@ints)   { order-game(flat @ints.map({ min($^a,$^b), max($^c,$^d) })) }
