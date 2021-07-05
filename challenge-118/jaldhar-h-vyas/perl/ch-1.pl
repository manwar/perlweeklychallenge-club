#!/usr/bin/perl
use 5.020;
use warnings;

my $N = shift // die "Must specify an integer.\n";

my $binary = sprintf "%b", $N;
say 0+($binary eq reverse $binary) ? 1 : 0;