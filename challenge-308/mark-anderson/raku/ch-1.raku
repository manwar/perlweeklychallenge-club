#!/usr/bin/env raku
use Test;

is count-common(<perl weekly challenge>, <raku weekly challenge>), 2;
is count-common(<perl raku python>,      <python java>),           1;
is count-common(<guest contribution>,    <fun weekly challenge>),  0;

sub count-common(@a, @b)
{
    +(@a ∩ @b)
}
