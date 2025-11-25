#! /usr/bin/env raku

unit sub MAIN ($path where $path ~~ /^ <[UDLR]>+ $/;

my $bag = $path.comb.Bag;

say $bag<L> == $bag<R> && $bag<U> == $bag<D>;

