#!/usr/bin/env raku

use Test;
plan 6;

is-deeply avg-seq(1 ... ∞),      (1, 1.5 ... 10.5)>>.narrow;
is-deeply avg-seq(1, 3 ... ∞),   (1 ... 20);
is-deeply avg-seq(2, 4 ... ∞),   (2 ... 21);
is-deeply avg-seq(3, 6 ... ∞),   (3, 4.5 ... 31.5)>>.narrow;
is-deeply avg-seq(4, 8 ... ∞),   (4, 6 ... 42);
is-deeply avg-seq(10, 20 ... ∞), (10, 15 ... 105);

sub avg-seq($seq)
{
    $seq.head(20).map({ .narrow with (state $sum += $_) / ++$ });
}    
