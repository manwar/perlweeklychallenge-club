#!/usr/bin/env raku

use Test;
plan 5;

is number-sequence(1234),  "1,2,3,4";
is number-sequence(91011), "9,10,11";
is number-sequence(10203), "10203";
is number-sequence(997998999100010011002100310041005), (997..1005).join(",");
is number-sequence(34567891011123456789101113), "3456789101112,3456789101113";

sub number-sequence($N)
{
    for ($N.chars div 2)...1
    {
        my $head = $N.substr(0, $_);
        my $s = [\~] $head...*;
        my ($k, $v) = $s.first(*.chars >= $N.chars, :kv);

        if $N eq $v
        {
            return ($head.Int..$head+$k).join(",");
        }
    }

    return $N;
}
