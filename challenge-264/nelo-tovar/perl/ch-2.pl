#!/usr/bin/env perl

# The Weekly Challenge 264 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
#
# Task 2 - Target Array
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    {source => [0, 1, 2, 3, 4], indices => [0, 1, 2, 2, 1]},
    {source => [1, 2, 3, 4, 0], indices => [0, 1, 2, 3, 0]},
    {source => [1], indices => [0]},
);

sub target_array {
    my $source = shift;
    my $indices = shift;
    my $len = scalar @$source - 1;
    my @target = ();

    splice @target, $indices->[$_], 0, $source->[$_] for 0 .. $len;

    return \@target;
}

for my $elements (@examples) {
    my $source = $elements->{source};
    my $indices = $elements->{indices};
    my $ta = target_array $source, $indices;

    say 'Input : @source = ', dump(@$source);
    say '        @indices = ', dump(@$indices);
    say 'Output : ', dump(@$ta);
    say ' ';
}
