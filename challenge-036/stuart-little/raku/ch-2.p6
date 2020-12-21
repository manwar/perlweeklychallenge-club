#!/usr/bin/env perl6
use v6;

# run as <script> <nr of boxes> or just <script> to default to arbitrary box count

my %boxes=(
    R => {w => 1, a => 1},
    B => {w => 1, a => 2},
    G => {w => 2, a => 2},
    Y => {w => 12, a => 4},
    P => {w => 4, a => 10},
);

sub weight_amount(@keys,%boxes) {
    @keys.map({ %boxes.{$_}.{'w'} }).sum,
    @keys.map({ %boxes.{$_}.{'a'} }).sum
}

sub knapsack(%boxes,$weightcap,$nr?) {
    %boxes.keys.combinations(($nr) ?? ($nr) !! (1..*)).map({ $_, $_.&weight_amount(%boxes) }).grep({ $_.[1].[0] < $weightcap }).max({ $_.[1].[1] })
}

say (@*ARGS) ?? (knapsack(%boxes,15,@*ARGS[0].Int)) !! (knapsack(%boxes,15))
