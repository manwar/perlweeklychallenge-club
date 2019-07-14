#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use bignum;

my $pie = 1;
my $max = 0;

my @guest;
for (1 .. 100) {
    my $part = $pie / 100 * $_;
    $pie -= $part;
    push @guest, $part;
    $max = $_ if $part > $guest[$max];
}

say $max, ' ', $guest[$max];
