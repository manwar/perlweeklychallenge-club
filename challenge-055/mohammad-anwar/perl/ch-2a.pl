#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;
use Algorithm::Combinatorics qw(permutations);

my $unit_tests = {
    1 => [ [1] ],
    2 => [ [2,1] ],
    3 => [ [2,1,3], [3,1,2] ],
    4 => [ [2,1,4,3], [3,1,4,2], [3,2,4,1], [4,1,3,2], [4,2,3,1] ],
};

foreach my $size (sort { $a <=> $b } keys %$unit_tests) {
    cmp_deeply(fetch_wave_array($size), $unit_tests->{$size}, "array size $size.");
}

done_testing;

sub fetch_wave_array {
    my ($N) = @_;

    die "ERROR: Invalid array size [$N]\n" unless ($N =~ /^\d+$/ && $N > 0);

    my $iter = permutations([ 1..$N ]);
    my $wave = [];
    while (my $array = $iter->next) {
        push @$wave, $array if is_wave($array);
    }

    return $wave;
}

sub is_wave {
    my ($array) = @_;

    my $is_wave = 1;
    foreach my $i (1..$#$array) {
        ($i % 2)
        ?
        ($array->[$i] <= $array->[$i-1])
        :
        ($array->[$i] >= $array->[$i-1])
        and next;

        $is_wave = 0;
        last;
    }

    return $is_wave;
}
