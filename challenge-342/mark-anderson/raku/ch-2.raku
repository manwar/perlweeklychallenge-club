#!/usr/bin/env raku
use Test;

is max-score("0011"),   4;
is max-score("0000"),   3;
is max-score("1111"),   3;
is max-score("0101"),   3;
is max-score("011101"), 5;

sub max-score($str)
{
    my @a = $str.comb;
    my %L is BagHash;
    my %R is BagHash = @a;

    pop @a;

    .max given do for @a 
    {
        %L{$_}++;
        %R{$_}--;
        %L{'0'} + %R{'1'}
    }
}
