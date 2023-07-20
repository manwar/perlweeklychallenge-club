#!/usr/bin/perl

# You are given an array of non-negative integers.  Write a script to return
# the minimum number of operations to make every element equal zero.  In each
# operation, you are required to pick a positive number less than or equal to
# the smallest element in the array, then subtract that from each positive
# element in the array.

use 5.036;
use utf8;

use List::Util qw(min uniq);

sub zero_array (@ints) {
    my @operations;
    while (my $n = min grep { $_ > 0 } @ints) {
        for (@ints) {
            if ($_ > 0) { $_ -= $n }
        }
        push @operations, [$n, [@ints]];
    }
    return @operations;
}

# The number of operations is equal to the number of unique positive numbers.
sub minimum_operations (@ints) {
    return scalar grep { $_ > 0 } uniq @ints;
}

sub print_operations (@ints) {
    my @operations = zero_array(@ints);
    printf "Input \@ints = (%s)\n", join ', ', @ints;
    printf "Output: %d\n", scalar @operations;
    my $i = 1;
    for (@operations) {
        printf "operation %d: pick %d => (%s)\n", $i, $_->[0], join ', ',
            @{$_->[1]};
        $i++;
    }
    return;
}

print_operations(1, 5, 0, 3, 5);
print "\n";
print_operations(0);
print "\n";
print_operations(2, 1, 4, 0, 3);
