#!/usr/bin/perl
use 5.030;
use warnings;

my $n = shift // die "Need a positive integer!\n";

my $flip = sprintf("%b", $n);
say oct '0b' . ($flip ^ (1 x (length $flip)));
