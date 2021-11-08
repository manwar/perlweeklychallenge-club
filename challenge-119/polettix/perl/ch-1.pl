#!/usr/bin/env perl
use v5.24;
sub swap_nibbles { ($_[0] & 0x0F) << 4 | $_[0] >> 4 }
my @inputs = @ARGV ? @ARGV : qw< 101 18 >;
say swap_nibbles($_) for @inputs;
