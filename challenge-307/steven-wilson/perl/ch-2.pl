#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;
use Memoize;
memoize('sortString');

sub findAnagrams {
    my @words = @_;
    my @drop_index  =  grep {
        sortString($words[$_]) eq
        sortString($words[$_ + 1]) }
        0..scalar @words - 2;
    return scalar @words - scalar @drop_index;
}

sub sortString {
    return join "", sort split //, shift;
}

is(findAnagrams("acca", "dog", "god", "perl", "repl") , 3, "Test 1");
is(findAnagrams("abba", "baba", "aabb", "ab", "ab") , 2, "Test 2");
done_testing();
