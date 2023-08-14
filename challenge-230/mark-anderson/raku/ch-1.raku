#!/usr/bin/env raku
use Test;

is-deeply separate-digits(1,34,5,6),     (1,3,4,5,6);
is-deeply separate-digits(<1 24 51 60>), (1,2,4,5,1,6,0);

sub separate-digits(*@a)
{
    @a.comb(/\d/)>>.Int
}
