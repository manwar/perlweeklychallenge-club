#!/usr/bin/env raku
use Test;

is sort-column(<swpc tyad azbe>), 2;
is sort-column(<cba daf ghi>),    1;
is sort-column(<a b c>),          0;

sub sort-column(+@list)
{
    ([Z] @list>>.comb)
    .grep({ not [lt] $_ })
    .elems
}
