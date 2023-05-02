#!/usr/bin/env raku
use Test;

ok  number-placement(<1 0 0 0 1>,         1);
nok number-placement(<1 0 0 0 1>,         2);
ok  number-placement(<1 0 0 0 0 0 0 0 1>, 3);
ok  number-placement(<1 1 0 0 1 0 0 0 1>, 1);
nok number-placement(<1 1 0 0 1 0 0 0 1>, 2);

sub number-placement($list, $count)
{
    $list.join ~~ m:g/ 00 <?before 0> / >= $count
}
