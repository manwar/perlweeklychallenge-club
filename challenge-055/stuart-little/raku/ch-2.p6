#!/usr/bin/env perl6
use v6;

sub wv(@a,$b) {
    $b eqv ().Bag && do {say @a; return};
    for $b.keys.grep({ (@a %% 2) ?? ($_ >= (@a[*-1] || -Inf)) !! ($_ <= (@a[*-1] || Inf)) }) {
	wv((|@a,$_),($b (-) $_))
    }
}

wv((), @*ARGS.map(*.Int).Bag)

# run as <script> <space-separated integers> 
