#!/usr/bin/perl

use v5.34;
use strict;
use warnings;

MAIN: {
    my $sentence = $ARGV[0];
    my $badkeys = $ARGV[1];

    my $count = scalar grep {! /[$badkeys]/i} split /\s+/, $sentence;

    say $count;
}
