#!/usr/bin/env raku
use Test;

is alpha-sum("abc",  1), 6;
is alpha-sum("az",   2), 9;
is alpha-sum("cat",  1), 6;
is alpha-sum("dog",  2), 8;
is alpha-sum("perl", 3), 6;

sub alpha-sum($str, $k)
{
    my $digits = $str.trans('a'..'z' => 1..26);
    $digits = $digits.comb.sum for 1..$k;
    return $digits       
}
