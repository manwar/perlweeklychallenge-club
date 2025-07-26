#!/usr/bin/env raku
use Test;

nok odd-letters("weekly");
ok  odd-letters("perl");
nok odd-letters("challenge");

sub odd-letters($str)
{
    so $str.comb.Bag.values.all.ends-with(any 1,3,5,7,9)   
}
