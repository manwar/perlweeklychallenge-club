#!/usr/bin/env perl

use v5.42;

use Test2::V0;

sub buddy_strings ($str1, $str2) {
    $str1 ne $str2 or return $str1 =~ /(\w).*\1/;
    my @l = map [split //, $_], $str1, $str2;
    $l[0]->@* == $l[1]->@* or return false;

    my @diffs = grep { $_ !~ /(\w)\1/ } map "$l[0][$_]$l[1][$_]", 0 .. $#{$l[0]};
    return @diffs == 2 && $diffs[0] eq reverse $diffs[1];
}

is buddy_strings('fuck', 'fcuk'), true, 'Example 1';
is buddy_strings('love', 'love'), false, 'Example 2';
is buddy_strings('fodo', 'food'), true, 'Example 3';
is buddy_strings('feed', 'feed'), true, 'Example 4';

done_testing;
