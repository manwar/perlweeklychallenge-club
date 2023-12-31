#!/usr/bin/env raku

sub equal-pairs (+ints) {
    my %bints := ints.Bag;

    %bints.kxxv.batch(2) if %bints.values.all %% 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    cmp-ok equal-pairs(3,2,3,2,2,2).sort, &[~~], ((2,2),(2,2),(3,3));
    is-deeply equal-pairs(1,2,3,4), Empty;
    done-testing;
}

multi MAIN (+ints) {
    say equal-pairs ints
}
