#!/usr/bin/perl

use strict;
use warnings;
use v5.40;

sub ch_327_1 {
    my @ints = @_;

    my %all = map {($_,1)} 1..@ints;
    delete @all{@ints};
    my @missing = sort keys %all;

    local $" = ', ';
    say "Inputs: (@ints)";
    say "Outputs: (@missing)";
}

ch_327_1(1, 2, 1, 3, 2, 5);
ch_327_1(1, 1, 1);
ch_327_1(2, 2, 1);
