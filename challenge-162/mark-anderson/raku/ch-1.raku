#!/usr/bin/env raku

use Test;

is check-digit('978-0-306-40615-7'), 7;
is check-digit('012-3-456-78921-0'), 0;

sub check-digit(\isbn)
{
    10 - (sum isbn.chop.comb(/\d/) >>*>> < 1 3 >) mod 10
    andthen .item < 10 ?? .item !! 0
}

