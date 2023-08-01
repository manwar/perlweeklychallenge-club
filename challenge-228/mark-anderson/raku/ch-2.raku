#!/usr/bin/env raku
use Test;

is  empty-array(<3 4 2>),                                                5;
is  empty-array(<1 2 3>),                                                3;
is  empty-array(<16 17 8 15 13 11 19 5 12 6 20 2 4 10 3 14 1 7 9 18>), 127;
say empty-array((^1000).pick(1000));

sub empty-array(*@a)
{
    sum do while @a
    {
        my $v = @a.antipairs.min.value;
        @a .= rotate($v);
        @a.shift;
        $v.succ
    }
}
