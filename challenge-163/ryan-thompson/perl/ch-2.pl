#!/usr/bin/env perl
#
# ch-2.pl - Summations
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use List::Util qw< sum >;
no warnings 'uninitialized';

say sum_rec(@ARGV);

sub sum_rec {
    my $first = shift;
    my $sum = 0;
    @_ ? sum_rec(map { $sum += $_ } @_) : $first;
}
