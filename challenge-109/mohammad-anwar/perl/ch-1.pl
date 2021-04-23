#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( top_chowla_number(20),
           [  0,  0,  0, 2,  0,
              5,  0,  6, 3,  7,
              0, 15,  0, 9,  8,
             14,  0, 20, 0, 21, ] );

done_testing;

sub top_chowla_number {
    my ($count) = @_;

    return [ map { chowla_number($_) } 1 .. $count ];
}

sub chowla_number {
    my ($n) = @_;

    my $sd = 0;
    map { $sd += $_ if $n % $_ == 0 } 2 .. $n/2;
    return $sd;
}
