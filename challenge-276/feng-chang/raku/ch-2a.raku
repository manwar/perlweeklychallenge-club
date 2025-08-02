#!/bin/env raku

unit sub MAIN(*@ints);

my %b = @ints.Bag;
my %s = (+«%b.max(:by({.value}), :k)).Set;
put +@ints.grep(%s);
