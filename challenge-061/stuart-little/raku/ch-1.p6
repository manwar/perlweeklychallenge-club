#!/usr/bin/env perl6
use v6;

sub maxprod(@a) {
    (@a.keys X @a.keys).grep({ $_[0] <= $_[1]}).map({ @a[$_[0]..$_[1]]}).classify({ $_.reduce(&infix:<*>)}).sort(*.key).reverse.first.value
}

@*ARGS.map(*.Int).&maxprod.say

# run as <script> <space-separated numbers>
