#! /usr/bin/perl6

use Test;

plan 3;

is(equaldistribution([1, 0, 5]), 4, 'example 1');
is(equaldistribution([0, 2, 0]), -1, 'example 2');
is(equaldistribution([0, 3, 0]), 2, 'example 3');

sub equaldistribution(@list) {
    my $s = @list.sum;
    if ($s % @list.elems != 0) {
        return -1;
    }
    my $m = $s div @list.elems;
    my $out = 0;
    my @w = @list;
    while (True) {
        for (0..@w.elems-2) -> $i {
            if (@w[$i] > $m) {
                my $v = @w[$i] - $m;
                @w[$i+1] += $v;
                $out += $v;
                @w[$i] = $m;
            } elsif (@w[$i] < $m) {
                my $v = min($m - @w[$i], @w[$i+1]);
                @w[$i+1] -= $v;
                $out += $v;
                @w[$i] += $v;
            }
        }
        if (@w.all == $m) {
            last;
        }
    }
    return $out;
}
