#!/usr/bin/perl

# You are given three arrays of integers.  Write a script to return all the
# elements that are present in at least 2 out of 3 given arrays.

use 5.036;
use utf8;

use experimental qw(builtin for_list);

use builtin qw(indexed);

sub count_one_bits ($bitset) {
    return unpack '%32b*', $bitset;
}

sub two_out_of_three (@arrays) {
    my %bitset_for;
    for my ($i, $array_ref) (indexed @arrays) {
        for (@{$array_ref}) {
            vec($bitset_for{$_}, $i, 1) = 1;
        }
    }
    my @sorted = sort { $a <=> $b }
        grep { count_one_bits($bitset_for{$_}) > 1 } keys %bitset_for;
    return @sorted;
}

sub print_array (@array) {
    return say '(', join(', ', @array), ')';
}

print_array(two_out_of_three([1, 1, 2, 4], [2, 4], [4]));
print_array(two_out_of_three([4, 1], [2, 4], [1, 2]));
