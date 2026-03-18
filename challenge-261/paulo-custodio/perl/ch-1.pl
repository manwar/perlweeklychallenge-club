#!/usr/bin/env perl

# Perl Weekly Challenge 261 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/

use Modern::Perl;
use List::Util 'sum';

my @ints = @ARGV;
my @digits = split //, join '', @ints;
say abs(sum(@ints) - sum(@digits));
