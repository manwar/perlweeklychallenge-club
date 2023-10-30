#!/usr/bin/env raku
use Test;

is-deeply common-characters(<java javascript julia>), <a j>;
is-deeply common-characters(<bella label roller>),    <e l l>;
is-deeply common-characters(<cool lock cook>),        <c o>;

sub common-characters(@a)
{
    [(&)] @a>>.comb>>.Bag andthen .kxxv.sort
}
