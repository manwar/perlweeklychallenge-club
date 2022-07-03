#!/usr/bin/env perl
#
# ch-1.pl - Abundant numbers
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

my $lim = $ARGV[0] // 10000;

# This returns 23 abundant numbers. Please do see
# my blog post and ch-1a.pl for a lot more information.
# https://ry.ca/2022/06/odd-abundant-numbers/

my @div_sum; # Sum of divisors for each number
for my $n (1..$lim) {
    $div_sum[$n*$_] += $n for 1..$lim/$n+1;
    say $n if $n % 2 and 2*$n <= $div_sum[$n];
}
