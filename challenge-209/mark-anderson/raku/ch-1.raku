#!/usr/bin/env raku
use Test;

ok  special-bit-chars(0);
ok  special-bit-chars(1,0,0);
ok  special-bit-chars(1,0,1,1,0);
ok  special-bit-chars(0,0,0,0,0,0);
ok  special-bit-chars(0,1,0,1,0,0);
ok  special-bit-chars(0,1,0,1,0,0);

nok special-bit-chars(1,1,1,0);
nok special-bit-chars(1,1,1,1,1,0);
nok special-bit-chars(1,1,0,0,1,0);
nok special-bit-chars(1,0,1,0,1,0);
nok special-bit-chars(0,0,0,0,1,0);

sub special-bit-chars(+$a)
{
    $a.join ~~ /^ [ 0 | 10 | 11 ]* 0 $/
}
