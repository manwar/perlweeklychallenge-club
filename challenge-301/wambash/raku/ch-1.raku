#!/usr/bin/env raku

sub largest-number (+@ints) {
    my $max-length = @ints.map(*.chars).max;

    @ints
    andthen .sort: { $_ x  $max-length }\
    andthen .reverse
    andthen [~] $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is largest-number(20, 3),320;
    is largest-number(3, 30, 34, 5, 9),9534330;
    done-testing;
}

multi MAIN (+@ints) {
    say largest-number @ints
}
