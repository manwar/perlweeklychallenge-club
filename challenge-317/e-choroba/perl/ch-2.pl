#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub friendly_strings($str1, $str2) {
    return if length($str1) != length $str2;
    my %diff;
    for my $i (0 .. length($str1) - 1) {
        my $char1 = substr $str1, $i, 1;
        my $char2 = substr $str2, $i, 1;
        if ($char1 ne $char2) {
            ++$diff{$char1}{1};
            ++$diff{$char2}{2};
        }
    }

    return 1 if 2 == keys %diff
             && 2 == grep 2 == keys %$_, values %diff;

    return
}

use Test2::V0;
plan(4 + 4);

is friendly_strings('desc', 'dsec'), bool(1), 'Example 1';
is friendly_strings('fuck', 'fcuk'), bool(1), 'Example 2';
is friendly_strings('poo', 'eop'), bool(0), 'Example 3';
is friendly_strings('stripe', 'sprite'), bool(1), 'Example 4';

is friendly_strings('stripe', 'stripe'), bool(0), 'Same string';
is friendly_strings('stripe', 'streip'), bool(0), 'Change 3';
is friendly_strings('abca', 'dbcd'), bool(0), 'Two differences but no swap';
is friendly_strings('stripe', 'strape'), bool(0), 'Single char difference';
