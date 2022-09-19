#!/usr/bin/env perl
# Week 180 Task 2
# You are given list of numbers, @n and an integer $i.
# Write a script to trim the given list where element is less than or equal to
# the given integer.

use strict;
use warnings;
use Test::More;

my @n_t1 = ( 1, 4, 2, 3, 5 );
my $i_t1 = 3;
my @r_t1 = ( 4, 5 );

my @n_t2 = ( 9, 0, 6, 2, 3, 8, 5 );
my $i_t2 = 4;
my @r_t2 = ( 9, 6, 8, 5 );

is_deeply( trim_list( $i_t1, \@n_t1 ), \@r_t1 );
is_deeply( trim_list( $i_t2, \@n_t2 ), \@r_t2 );
done_testing();

sub trim_list {
    my $i     = shift;
    my $n_ref = shift;
    my @r     = grep { $_ > $i } @{$n_ref};
    return \@r;
}
