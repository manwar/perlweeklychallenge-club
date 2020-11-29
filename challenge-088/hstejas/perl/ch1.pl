#!/usr/bin/env perl

use strict;
use warnings;
use v5.30;


sub array_of_product {
    my $n = shift;
    my @m;
    my $product = 1;
    map { $product *= $_ } @{$n};

    for(my $idx = 0; $idx < scalar @{$n}; $idx++) {
        push @m, $product / $n->[$idx];
    }
    return \@m;
}

my @n = (5, 2, 1, 4, 3);
say join ', ', @{array_of_product(\@n)};

@n = (2, 1, 4, 3);
say join ', ', @{array_of_product(\@n)};