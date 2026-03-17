#!/usr/bin/env perl

# Perl Weekly Challenge 320 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums...\n";
my @nums = @ARGV;
my $num_positive = scalar grep {$_>0} @nums;
my $num_negative = scalar grep {$_<0} @nums;
say max($num_negative, $num_positive);
