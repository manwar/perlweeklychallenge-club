#!/usr/bin/env raku
use Test;

is cont-array(1,0),         2;
is cont-array(0,1,0),       2;
is cont-array(0,0,0,0,0),   0;
is cont-array(0,1,0,0,1,0), 4;

sub cont-array(+@b)
{
    $_ = -1 unless $_ for @b;

    max ([\+] 0, |@b).pairs
                     .classify({ .values }, :as{ .key })
                     .values
                     .map({ .tail - .head })
}
