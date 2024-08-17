#!/usr/bin/env raku
use Test;

is reverse-word("challenge",   "e"), "acehllnge";
is reverse-word("programming", "a"), "agoprrmming";
is reverse-word("champion",    "b"), "champion";

sub reverse-word($str, $char)
{
    my $list = $str.split($char, 2); 
    return $str unless $list.elems == 2;
    return ($list.head.comb, $char).flat.sort.join ~ $list.tail
}
