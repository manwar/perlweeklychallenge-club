#!/usr/bin/env perl

# Perl Weekly Challenge 327 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my %nums; $nums{$_}=1 for @nums;
my @missing = grep {!$nums{$_}} 1 .. @nums;
say join ", ", @missing;
