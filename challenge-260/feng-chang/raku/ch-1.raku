#!/bin/env raku

unit sub MAIN(*@ints);

my @a = @ints.Bag.values;
put +(+@a.unique == +@a);
