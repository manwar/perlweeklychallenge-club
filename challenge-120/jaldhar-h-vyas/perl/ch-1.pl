#!/usr/bin/perl
use 5.020;
use warnings;

my $N = shift // die "Must specify an integer.\n";

my $n = sprintf "%b", $N;
if ((length $n) % 8 != 0) {
    $n = 0 x (8 - (length $n) % 8) . $n;
}

say oct '0b' . join q{}, map {  $_ = reverse; } (unpack '(A2)*', $n);
