#! /usr/bin/perl
use warnings;
use strict;

# Visible impact for tests #2 and #3.
use Memoize;
memoize('_coins_sum');

sub _coins_sum {
    my ($sum, @coins) = @_;
    my @r;
    for my $coin (@coins) {
        next if $sum < $coin;
        push @r, $sum == $coin
                 ? [$coin]
                 : map [ $coin, @$_ ],
                   grep $_->[0] >= $coin,
                   do { no warnings 'recursion';
                        _coins_sum($sum - $coin, @coins) };
    }
    return @r
}

sub coins_sum {
    my ($sum, @coins) = @_;
    my @r = _coins_sum($sum, @coins);
    return scalar @r
}

use Test::More tests => 3;

is coins_sum(6,  1, 2, 4), 6;
is coins_sum(24, 1, 2, 4), 49;
is coins_sum(80, 2, 7), 6;
