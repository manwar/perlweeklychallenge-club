#!/usr/bin/env raku
use Test;

is max-avg([1,12,-5,-6,50,3], 4), 12.75;
is max-avg([5], 1),               5;

sub prefix:<x̄>(@list) { @list.sum / @list.elems }

sub max-avg(@ints, $n)
{
    @ints.rotor($n => 1-$n).map(x̄ *).max

}
