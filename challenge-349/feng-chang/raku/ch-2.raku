#!/bin/env raku

unit sub MAIN(Str:D $s);

put [.<U>,.<L>] eqv [.<D>,.<R>] with $s.comb.Bag;
