#!/usr/bin/env raku
use Test;

ok  freq-equalizer('abbc');
ok  freq-equalizer('xyzyyxz');
nok freq-equalizer('xzxz');
ok  freq-equalizer('xxxxx');
nok freq-equalizer('aaaabbbcc');
nok freq-equalizer('aabbcd');
ok  freq-equalizer('aabbccd');
ok  freq-equalizer('z');

sub freq-equalizer($_)
{
    my $bag = .comb.BagHash;

    if $bag.minpairs == 1  
    {
        $bag{ $bag.antipairs.min.value }--
    }
     
    else
    {
        $bag{ $bag.antipairs.max.value }--
    }

    [==] $bag.values
}
