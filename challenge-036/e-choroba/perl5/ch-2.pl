#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

my %weight = (
    R => 1,
    B => 1,
    G => 2,
    Y => 12,
    P => 4);

my %price = (
    R => 1,
    B => 2,
    G => 2,
    Y => 4,
    P => 10);

my $MAX_WEIGHT = 15;

my @boxes = keys %weight;

sub binary_plusplus {
    my ($n) = @_;
    my $p = 0;
    $n->[$p++] = 0 while $n->[$p] != 0;
    $n->[$p] = 1;
}

sub pick {
    my ($max_count) = @_;
    my @mask = ('0') x keys %weight;
    my %best = (mask => [@mask], price => 0);
    while (grep ! $_, @mask) {
        next if $max_count < grep $_, @mask;

        my $w = sum(map $mask[$_] * $weight{ $boxes[$_] },
                    0 .. $#mask);
        my $p = sum(map $mask[$_] *  $price{ $boxes[$_] },
                    0 .. $#mask);

        next if $w > $MAX_WEIGHT;

        %best = (mask => [@mask], price => $p)
            if $p > $best{price};

    } continue {
        binary_plusplus(\@mask);
    }

    return [ map $best{mask}[$_]
             ? (keys %weight)[$_]
             : (), 0 .. $#mask ]
}

use Test::More tests => 5;
use Test::Deep;

cmp_deeply pick(5), bag(qw( R B G P ));

cmp_deeply pick(4), bag(qw( R B G P ));

cmp_deeply pick(3), bag(qw( B P G ));

cmp_deeply pick(2), any(bag(qw( B P )), bag(qw( G P )));

cmp_deeply pick(1), [qw[ P ]];
