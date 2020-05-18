#!/usr/bin/env raku

sub MAIN (*@array) {
    my %hash;

    for (2 .. @array.keys.max) -> $i {
        my @subs = @array.rotor($i);

        %hash{@subs} = @subs.map({[*] .Array});

        @subs = @array.reverse.rotor($i).map(*.reverse);

        %hash{@subs} = @subs.map({[*] .Array});
    }

    .say for %hash.maxpairs;
}
