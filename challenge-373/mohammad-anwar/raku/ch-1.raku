#!/usr/bin/env raku

use Test;

my @examples = (
    {
        in  => [["a", "bc"], ["ab", "c"]],
        out => "true"
    },
    {
        in  => [["a", "b", "c"], ["a", "bc"]],
        out => "true"
    },
    {
        in  => [["a", "bc"], ["a", "c", "b"]],
        out => "false"
    },
    {
        in  => [["ab", "c", ""], ["", "a", "bc"]],
        out => "true"
    },
    {
        in  => [["p", "e", "r", "l"], ["perl"]],
        out => "true"
    },
);

for @examples -> %ex {
    is equal-list(|%ex<in>), %ex<out>;
}

done-testing;

sub equal-list(@arr1, @arr2) {
    return @arr1.join eq @arr2.join ?? "true" !! "false";
}
