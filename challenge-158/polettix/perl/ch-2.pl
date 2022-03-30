#!/usr/bin/env perl
use v5.24;
use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use ntheory 'is_prime';

my $M = shift // 1000;
my @cubans;
my $y = 1;
while ((my $p = 3 * $y * ($y + 1) + 1) <= $M) {
   push @cubans, $p if is_prime($p);
   ++$y;
}
say join(', ', @cubans), '.';
