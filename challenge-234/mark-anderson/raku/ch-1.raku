#!/usr/bin/env raku
use Test;

is-deeply common-character(<java javascript julia>), <a j>;
is-deeply common-character(<bella label roller>),    <e l l>;
is-deeply common-character(<cool lock cook>),        <c o>;

sub common-character(@a)
{
    [(&)] @a>>.comb>>.Bag andthen .kxxv.sort
}
