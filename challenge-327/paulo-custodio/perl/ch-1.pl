#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my %nums; $nums{$_}=1 for @nums;
my @missing = grep {!$nums{$_}} 1 .. @nums;
say join ", ", @missing;
