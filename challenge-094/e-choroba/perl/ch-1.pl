#!/usr/bin/perl
use warnings;
use strict;

sub group_anagrams {
    my @words = @_;
    my %groups;
    for my $word (@words) {
        my %f;
        ++$f{$_} for split //, $word;
        push @{ $groups{ join '|', map "$_$f{$_}", sort keys %f } }, $word
    }
    return [ values %groups ]
}

use Test::More tests => 3;
use Test::Deep;

cmp_deeply group_anagrams(qw( opt bat saw tab pot top was )),
    bag(bag(qw( bat tab )),
        bag(qw( saw was )),
        bag(qw( top pot opt ))), 'Example 1';

cmp_deeply group_anagrams('x'), [['x']], 'Example 2';

cmp_deeply group_anagrams(qw( pool loop lop poll plop pool )),
    bag(bag(qw( pool loop pool )),
        ['lop'], ['poll'], ['plop']), 'Duplicate letters and words';
