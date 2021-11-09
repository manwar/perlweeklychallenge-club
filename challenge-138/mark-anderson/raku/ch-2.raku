#!/usr/bin/env raku

use Test;
plan 9;

isnt split-number(36),        1;         
is   split-number(81),        1, '9 = 8 + 1';
is   split-number(100),       1, '10 = 10 + 0';
is   split-number(9801),      1, '99 = 98 + 0 + 1'; 
is   split-number(55225),     1, '235 = 5 + 5 + 225';
is   split-number(136161),    1, '369 = 1 + 361 + 6 + 1';
is   split-number(11329956),  1, '3366 = 11 + 3299 + 56';
is   split-number(57562569),  1, '7587 = 5 + 7562 + 5 + 6 + 9';
is   split-number(100000000), 1, '10000 = 10000 + 0 + 0 + 0 + 0';

sub split-number($n)
{
    for terms($n.chars)
    {
        my @a = $n.comb.rotor($_);
        next if first { .elems > 1 and .head == 0 }, @a;
        return 1 if @a.map(*.join).sum == $n.sqrt;
    }

    return 0;
}

sub terms($n) 
{
    map { ((.fmt: '%0' ~ $n ~ 'b') ~~ m:g/ (.) [$0+]? /).map(*.chars) }, 
                                                         1..2**($n-1)-1; 
}
