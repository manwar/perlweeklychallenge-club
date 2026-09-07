#!/usr/bin/env raku
use Test;

is-deeply uncommon-words("apple banana apple", "banana orange"),     <orange>.Set;
is-deeply uncommon-words("cat dog", "bird fish"),                    <cat dog bird fish>.Set;
is-deeply uncommon-words("the quick brown fox", "the quick"),        <brown fox>.Set;
is-deeply uncommon-words("hello", "hello"),                          Empty.Set;
is-deeply uncommon-words("blue blue red", "red green green yellow"), <yellow>.Set;

sub uncommon-words($s1, $s2)
{
    my $s = ($s1.words, $s2.words).flat.List;
    $s (-) $s.repeated
}
