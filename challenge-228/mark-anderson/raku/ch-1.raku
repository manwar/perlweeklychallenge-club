#!/usr/bin/env raku
use Test;

is  unique-sum(<2 1 3 2>),  4;
is  unique-sum(<1 1 1 1>),  0;
is  unique-sum(<2 1 3 4>), 10;
say unique-sum((^1000).roll(1000));

sub unique-sum(*@a)
{
    sum do map {.key}, @a.Bag.grep(*.value == 1)
}
