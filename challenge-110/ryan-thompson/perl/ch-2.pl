#!/usr/bin/env perl
#
# ch-2.pl - Transpose a file (CSV)
#
# 2021 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use autodie;
no warnings 'uninitialized';

my @rows = map { chomp; [ split ',' ] } <>;

for my $col (0..$#{$rows[0]}) {
    say join ',', map { $_->[$col] } @rows
}
