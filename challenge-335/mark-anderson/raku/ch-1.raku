#!/usr/bin/env raku
use Test;

is-deeply common-characters(< bella label roller >), < e l l >;
is-deeply common-characters(< cool lock cook >),     < c o >;
is-deeply common-characters(< hello world pole >),   < l o >;
is-deeply common-characters(< abc def ghi >),        ();
is-deeply common-characters(< aab aac aaa >),        < a a >;

sub common-characters(@words)
{
    my @bags = @words>>.comb>>.Bag;
    ([(&)] @bags).kxxv.sort
}
