#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{sum0};

my @numbers = sort (34, 50, 52, 10 );

for my $n ( @numbers ) {
    my $b = sum_of_squares($n);
    say join "\t", $n,$b?'Yes':'No';
}

sub sum_of_squares ( $n ) {
    my $sum = sum0 map { $_ ** 2 } split //, $n;
    my $root = sqrt $sum;
    return int $root == $root ? 1 : 0 ;
}