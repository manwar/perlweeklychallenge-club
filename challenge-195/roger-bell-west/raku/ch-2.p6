#! /usr/bin/perl6

use Test;

plan 3;

is(mostfrequenteven([1, 1, 2, 6, 2]), 2, 'example 1');
is(mostfrequenteven([1, 3, 5, 7]), -1, 'example 2');
is(mostfrequenteven([6, 4, 4, 6, 1]), 4, 'example 3');

sub mostfrequenteven(@l) {
    my %f;
    for @l -> $n {
        if ($n % 2 == 0) {
            %f{$n}++;
        }
    }
    if (%f.elems > 0) {
        my $m = %f.values.max;
        my @l = grep {%f{$_} == $m}, %f.keys;
        @l = @l.sort;
        return @l[0];
    } else {
        return -1;
    }
}
