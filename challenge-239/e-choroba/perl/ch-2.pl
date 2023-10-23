#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub consistent_strings($str, $allowed) {
    my $regex = qr/^[\Q$allowed\E]*$/;
    return scalar grep /$regex/, @$str
}

use Test::More tests => 3 + 2;

is consistent_strings(["ad", "bd", "aaab", "baa", "badab"], "ab"),
    2, 'Example 1';
is consistent_strings(["a", "b", "c", "ab", "ac", "bc", "abc"], "abc"),
    7, 'Example 2';
is consistent_strings(["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad"),
    4, 'Example 3';

is consistent_strings(["", ""], 'xyz'),
    2, 'Empty strings';

is consistent_strings(['[[', ']]', '$$', '^^', '\\\\'], '\\[]^$'),
    5, 'Special characters';
