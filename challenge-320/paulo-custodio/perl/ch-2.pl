#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my @digits = split //, join '', @nums;
say abs(sum(@nums) - sum(@digits));
