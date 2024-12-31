#!/usr/bin/env raku
use Test;

is ones-and-zeroes(< 10 0001 111001 1 0 >, 5, 3), 4;
is ones-and-zeroes(< 10 1 0 >,             1, 1), 2;

sub ones-and-zeroes(@str is copy, $x, $y)
{
    for @str.combinations.reverse
    {
        my $str = [~] $_;
        my $zeroes = $str.comb('0').elems;
        my $ones = $str.chars - $zeroes;
        return .elems if all($zeroes <= $x, $ones <= $y)
    }
}
