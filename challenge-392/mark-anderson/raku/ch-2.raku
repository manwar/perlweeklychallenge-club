#!/usr/bin/env raku
use Test;

is words-length-product(< a ab abc d de def >),       9;
is words-length-product(< a aa aaa aaaa >),           0;
is words-length-product(< meet app code sky bold >), 16;
is words-length-product(< a ab abc abcd efghi >),    20;
is words-length-product(< xyz w abcdefg hij >),      21;

sub words-length-product(@words)
{
    my @bags = @words>>.comb>>.Bag.unique: with => &[eqv];

    .max given flat 0, gather for ^@bags -> $a 
    {
         for $a^..^@bags -> $b
         {
             next if @bags[$a].keys (&) @bags[$b].keys;
             take @bags[$a].total * @bags[$b].total
         }
    }
}
