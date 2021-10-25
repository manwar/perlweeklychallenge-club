#!/usr/bin/perl
use 5.020;
use warnings;

my $n = shift // die "Need an integer.\n";

$n =~ s/^\-//;

if ($n !~ /^\d+$/) {
    die "Not an integer.\n";
}

my $len = length $n;

if ($len % 2 == 0) {
    die "Even number of digits\n";
}

if ($len < 3) {
    die "Too short.\n";
}

say substr $n, ($len - 3) / 2, 3;