#!/usr/bin/env perl6

use Test;

my $unit-tests = :{
    1 => [ (1,), ],
    2 => [ (2,1), ],
    3 => [ (2,1,3), (3,1,2) ],
    4 => [ (2,1,4,3), (3,1,4,2), (3,2,4,1), (4,1,3,2), (4,2,3,1) ]
};

for $unit-tests.keys.sort -> $size {
    is-deeply(fetch-wave-array($size), $unit-tests{$size}, "array size $size");
}

done-testing;

sub fetch-wave-array($size) {
    die "ERROR: Invalid array size [$size]\n"
        unless ($size ~~ /^\d+$/ && $size > 0);

    my @N = (1 .. $size).permutations();
    my $wave = [];
    for @N -> @array {
        push @$wave, @array if is-wave(@array);
    }

    return $wave;
}

sub is-wave(@array) {

    my $is-wave = 1;
    for 1 .. @array.elems-1 -> $i {
        ($i mod 2 == 1)
        ??
        (@array[$i] <= @array[$i-1])
        !!
        (@array[$i] >= @array[$i-1])
        and next;

        $is-wave = 0;
        last;
    }

    return $is-wave;
}
