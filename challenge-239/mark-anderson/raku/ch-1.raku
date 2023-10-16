#!/usr/bin/env raku
use Test;

ok  same-string(<ab c>, <a bc>);
nok same-string(<ab c>, <ac b>);
ok  same-string(<ab cd e>, [<abcde>]);

sub same-string(@a, @b)
{
    [eq] ([~] @a), ([~] @b)
}
