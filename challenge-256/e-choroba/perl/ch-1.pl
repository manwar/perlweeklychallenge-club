#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub maximum_pairs(@words) {
    my $pair_tally = 0;
    my %seen;
    for my $word (@words) {
        # By checking before booking we don't have to special case
        # palindromes.
        ++$pair_tally if exists $seen{ reverse $word };
        undef $seen{$word};
    }
    return $pair_tally
}

use Test::More tests => 3;

is maximum_pairs('ab', 'de', 'ed', 'bc'), 1, 'Example 1';
is maximum_pairs('aa', 'ba', 'cd', 'ed'), 0, 'Example 2';
is maximum_pairs('uv', 'qp', 'st', 'vu', 'mn', 'pq'), 2, 'Example 3';
