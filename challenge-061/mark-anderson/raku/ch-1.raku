#!/usr/bin/env raku

sub MAIN (*@array) {
    my %hash;

    for (2 .. @array.keys.max) -> $i {
        my @subs = @array.rotor($i => -($i-1));

        %hash{@subs} = @subs.map({[*] .Array});
    }

    .say for %hash.maxpairs;
}
