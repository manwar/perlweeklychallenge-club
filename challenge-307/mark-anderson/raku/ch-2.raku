#!/usr/bin/env raku
use Test;

is find-anagrams(<acca dog god perl repl>), 3;
is find-anagrams(<abba baba aabb ab ab>),   2;

sub find-anagrams(@words)
{
    + squish @words>>.comb>>.Bag
}
