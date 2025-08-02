#!/usr/bin/env perl

# The Weekly Challenge 268 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
#
# Task 1 - Magic Number
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    { x => [3, 7, 5], y => [9, 5, 7] },
    { x => [1, 2, 1], y => [5, 4, 4] },
    { x => [2], y => [5] },
);

sub magic_number {
    my $x = shift;
    my $y = shift;
    my @xx = sort @$x;
    my @yy = sort @$y;

    return abs($xx[0] - $yy[0])
}

for my $elements (@examples) {
    my $mn = magic_number $elements->{x}, $elements->{y};

    say 'Input : @x = ', dump($elements->{x});
    say '        @y = ', dump($elements->{y});
    say 'Output : ', $mn;
    say ' ';
}
