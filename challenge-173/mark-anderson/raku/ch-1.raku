#!/usr/bin/env raku
use Test;

ok  esthetic(5456);
nok esthetic(120);
ok  esthetic(123456789);
ok  esthetic(987654321);
ok  esthetic(98765432123456789);
nok esthetic(987654321123456789);
nok esthetic(3123);
nok esthetic(21231);
ok  esthetic(454323);

sub esthetic($n)
{
    not $n ~~ / (\d)(\d) <?{ $0 - $1 !== 1|-1 }> /
}
