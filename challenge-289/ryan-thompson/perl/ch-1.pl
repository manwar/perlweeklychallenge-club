#!/usr/bin/env perl
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use List::Util qw< uniq >;

# Find the ntj distinct maximum in the given array
# BUT if the nth max doesn't exist, we return the overall max.
# Overall complexity is O(n log n) due to the sort
sub nth_max {
    my $n = shift;
    my @uniq_sorted = uniq sort { $b <=> $a } @_;

    $uniq_sorted[ @uniq_sorted >= $n ? $n - 1 : 0 ]
}

sub third_max { nth_max(3 => @_) }

say third_max @ARGV;
