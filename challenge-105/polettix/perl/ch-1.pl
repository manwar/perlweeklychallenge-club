#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub nth_root ($N, $k) { return $N ** $k ** -1 }

my $N_ = shift || 34;
my $k_ = shift || 5;
say nth_root($N_, $k_);
