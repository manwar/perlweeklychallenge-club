#!/usr/bin/env raku

sub min-max (+ints) {
    my $mm=ints.minmax.minmax;

    ints.grep: * == $mm.none
}

multi MAIN (Bool :test($)!) {
    use Test;
    is min-max(3,2,1,4),(3,2);
    is min-max(3,1),();
    is min-max(2,1,3),(2);
    done-testing;
}

multi MAIN (+ints) {
    put min-max(ints) || -1
}
