#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is( max_product_subarray([ 2, 5, -1, 3]), "[ 2, 5 ]" );

done_testing;

sub max_product_subarray {
    my ($array) = @_;

    my $subarray = {};
    foreach my $i (0 .. $#$array) {
        foreach my $j ($i .. $#$array-1) {
            my @x = ();
            my $y = 1;
            foreach my $k ($i .. ++$j) {
                push @x, $array->[$k];
                $y *= $array->[$k];
            }
            $subarray->{sprintf("[ %s ]", join ", ", @x)} = $y;
        }
    }

    return [
        sort { $subarray->{$b} <=> $subarray->{$a} } keys %$subarray
    ]->[0];
}
