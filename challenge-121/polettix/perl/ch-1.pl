#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub invert_bit ($m, $n) { $m ^ (1 << --$n) }
say "m=12 n=3 -> " . invert_bit(12, 3);
say "m=18 n=4 -> " . invert_bit(18, 4);
