#!/usr/bin/env perl
#
# ch-2.pl - Strong Pair
#
# Return the count of all strong pairs in the given array
# A pair of integers is strong if 0 < | x - y | < min(x,y)
#
# See blog post for more information:
# https://ry.ca/2024/07/pwc-277-strong-pair-counting-common/
#
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Carp;
use List::Util qw< uniq min >;
no warnings 'uninitialized';

sub strong_pair {
    ref || $_ !~ /^\-?\d+$/ and croak 'Arguments must be integers' for @_;
    my @i = uniq sort { $a <=> $b } @_;

    grep { my ($x,$y) = @$_; $x < $y and $y < 2*$x }
     map { my $i = $_; map { [ @_[$i,$_] ] } $i+1..$#i } 0..$#i
}

1;
