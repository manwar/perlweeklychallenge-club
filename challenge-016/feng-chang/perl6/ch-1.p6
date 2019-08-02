#!/bin/env perl6

my $pie = 1;
my @share = 0;

for 1..100 -> $i {
    @share[$i] = $pie * $i / 100;
    $pie -= @share[$i];
}

@share.pairs.max(*.value).key.say;
