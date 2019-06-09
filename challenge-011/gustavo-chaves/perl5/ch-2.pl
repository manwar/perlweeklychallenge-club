#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;

my $n = shift or die "Usage: $0 N\n";

my @matrix = map {[(0) x $n]} (1 .. $n);

$matrix[$_][$_] = 1 foreach (0 .. $n-1);

ddx \@matrix;
