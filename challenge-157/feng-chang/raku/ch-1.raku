#!/bin/env raku

unit sub MAIN(*@a);

my UInt \n = @a.elems;
my %medians =
    'AM' => @a.sum / n,
    'GM' => ([*] @a) ** (1/n),
    'HM' => n / @a.map(1/*).sum;

put %medians.keys.sort.map({ "$_ = ", %medians{$_}.fmt('%.2f') }).join(', ');
