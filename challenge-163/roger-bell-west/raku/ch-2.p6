#! /usr/bin/perl6

use Test;

plan 2;

is(summation([1,2,3,4,5]),42,'example 1');
is(summation([1,3,5,7,9]),70,'example 2');

sub summation(@ls0) {
    my @ls = @ls0;
    while (@ls.elems > 1) {
        my @lv;
        for 1..@ls.elems-1 -> $i {
            @lv.push((1..$i).map({@ls[$_]}).sum);
        }
        @ls = @lv;
    }
    return @ls[0];
}
