#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Math::BigInt;

my $it = sylvester_sequence_it();
say $it->() for 1 .. shift // 10;

sub sylvester_sequence_it {
   my $n;
   return sub { $n = $n ? 1 + $n * ($n - 1) : Math::BigInt->new(2) }
}
