#!/usr/bin/perl

# Write a script to return the count of words that start with a given prefix.

use 5.036;
use utf8;

sub filter_words ($prefix, @words) {
    my $n = length $prefix;
    return grep { $prefix eq substr $_, 0, $n } @words;
}

say scalar filter_words('at', qw(pay attention practice attend));
say scalar filter_words('ja', qw(janet julia java javascript));
