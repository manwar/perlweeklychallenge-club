#!/usr/bin/env perl
#
# ch-1.pl - Count Common
#
# Count of words that appears in both arrays exactly once
# My version supports an arbitrary number of arrays, instead of just two.
# Modifying or wrapping it to limit it to two would be trivial.
# Does NOT sort results by default. This is a minor optimization.
# Sort if you need stable results.
#
# See blog post for more information:
# https://ry.ca/2024/07/pwc-277-strong-pair-counting-common/
#
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Carp;
use List::Util qw< all >;
no warnings 'uninitialized';

sub count_common {
    'ARRAY' ne ref and croak 'Arguments must be ARRAY refs' for @_; # VAL
    my @once; # $once[$idx]{word} = # True if 'word' appears once in $_[$idx]

    for my $i (keys @_) {
        my %freq; $freq{$_}++ for @{ $_[$i] };
        $once[$i]{$_} = 1 for grep { $freq{$_} == 1 } keys %freq;
    }
    
    grep { my $w = $_; all { $_->{$w} } @once } keys %{$once[0]}
}

1;
