#!/usr/bin/env raku
use Test;

is mac-address('1ac2.34f0.b1c2'), '1a:c2:34:f0:b1:c2';
is mac-address('abc1.20f1.345a'), 'ab:c1:20:f1:34:5a';

subset Mac of Str where /^ [ <[0..9a..f]> ** 4 ] ** 3 % '.' $/;

sub mac-address(Mac $mac is copy)
{
    given $mac
    {
        s:g/\.//;
        s:g/(..) <?before ..>/$0:/;
        .return
    }
}
