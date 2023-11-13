#!/usr/bin/env perl
# Perl weekly challenge 243
# Task 2:  Floor Sum
#
# See https://wlmb.github.io/2023/11/13/PWC243/#task-2-floor-sum
use v5.36;
use PDL;
my $in=pdl(@ARGV);
say "$in -> ", ($in/$in->dummy(0))->floor->sum;
