#!/usr/bin/env raku
use Test;

ok  equal-list(<a bc>, <ab c>);
ok  equal-list(<a b c>, <a bc>);
nok equal-list(<a bc>, <a c b>);
ok  equal-list(["ab", "c", ""], ["", "a", "bc"]);
ok  equal-list(<p e r l>, ["perl"]);

sub equal-list(@a, @b)
{
    ([~] @a) eq ([~] @b) 
}
