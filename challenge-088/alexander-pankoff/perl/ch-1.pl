#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(product);

{
    my @N = ( 5, 2, 1, 4, 3 );
    my @M = array_of_product(@N);
    say '(' . join( ', ', @M ) . ')';
}

sub array_of_product(@arr) {

    # we first calculate the product of all array elements
    my $total = product(@arr);

    # each item in the output is then the result of factoring out the
    # corresponding element from the input list from that total
    my @out = map { $total / $_ } @arr;

    return @out;
}
