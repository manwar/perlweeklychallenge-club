#!/usr/bin/env raku
use Test;

ok  freq-equalizer('abbc');
ok  freq-equalizer('xyzyyxz');
nok freq-equalizer('xzxz');
ok  freq-equalizer('xxxxx');

sub freq-equalizer($_)
{
    my $bag = .comb.BagHash;
    $bag{ $bag.antipairs.max.value }--;
    [==] $bag.values;
}
