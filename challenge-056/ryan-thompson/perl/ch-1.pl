#!/usr/bin/env perl
#
# ch-1.pl - Diff-K
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

# Diff-K
sub diff_k {
    my $k = shift;
    my %idx_of = map { $_[$_] => $_ } 0..$#_;

    map  {      [ @idx_of{ $k+$_, $_ } ] }
    grep { exists $idx_of{ $k+$_ }       } @_;
}

my @list = qw< 0  2  3  5  6  7  9 10 11 14 15 16 17 18 19 21 22
              25 28 29 31 32 33 34 35 37 38 40 41 44 46 47 48 49>;
say "@list";

say join ' ', map "[$_->[0], $_->[1]]", diff_k(30, @list);
