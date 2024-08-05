#!/usr/bin/env raku
use Test;

ok  check-color('d3');
nok check-color('g5');
ok  check-color('e6');

sub check-color($coordinates)
{
    if $coordinates ~~ /(<.alpha>)(<.digit>)/ -> ($col, $row)
    {
        one($col.ord, $row) %% 2 # XOR
    }
}
