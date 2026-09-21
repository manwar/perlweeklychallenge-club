#!/usr/bin/env raku
use Test;

is words-length-product(< a ab abc d de def >),       9;
is words-length-product(< a aa aaa aaaa >),           0;
is words-length-product(< meet app code sky bold >), 16;
is words-length-product(< a ab abc abcd efghi >),    20;
is words-length-product(< xyz w abcdefg hij >),      21;
is words-length-product(< Vertumnus is an oil painting by the Italian 
artist Giuseppe Arcimboldo depicting Rudolf II Holy Roman Emperor as 
Vertumnus the Roman god of changing seasons gardens fruit trees and 
plant growth Rudolfs portrait is composed of fruits vegetables and 
flowers and combines visual humour with political allegory presenting
him as a ruler possessing harmony with and power over nature Seized
by Swedish forces after the Thirty Years War the painting is now held
at Skokloster Castle in Sweden >),                   80;

sub words-length-product(@words)
{
    my @bags = @words>>.comb>>.Bag.unique(with => &[eqv]);

    .max given flat 0, gather for @bags.combinations(2) 
    {
         next if .head (&) .tail;
         take .head * .tail
    }
}
