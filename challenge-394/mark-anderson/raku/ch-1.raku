#!/usr/bin/env raku
use Test;

is alternate-case("aAbB"),   0;
is alternate-case("AAbb"),   1;
is alternate-case("AAAbbb"), 3;
is alternate-case("aABb"),   1;
is alternate-case("bBBAaa"), 2;

sub alternate-case($str)
{
    return min swaps('<lower>'), swaps('<upper>');

    sub swaps($re)
    {
        my $expected := (0,2...^$str.chars);
        $str ~~ m:g/<$re>/;
        ($expected >>-<< $/>>.from)>>.abs.sum
    }
}
