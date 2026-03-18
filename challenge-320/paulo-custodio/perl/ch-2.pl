#!/usr/bin/env perl

# Perl Weekly Challenge 320 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my @digits = split //, join '', @nums;
say abs(sum(@nums) - sum(@digits));
