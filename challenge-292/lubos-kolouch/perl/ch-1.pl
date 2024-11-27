#!/usr/bin/perl
use strict;
use warnings;

sub twice_largest_index {
    my @ints = @_;
    
    # Edge case: Empty array
    return -1 unless @ints;

    # Find the largest element and its index
    my $max_value = $ints[0];
    my $max_index = 0;
    
    for my $i (1 .. $#ints) {
        if ($ints[$i] > $max_value) {
            $max_value = $ints[$i];
            $max_index = $i;
        }
    }
    
    # Check if the largest element is at least twice as big as every other element
    for my $i (0 .. $#ints) {
        next if $i == $max_index;  # Skip the largest element itself
        if ($max_value < 2 * $ints[$i]) {
            return -1;
        }
    }
    
    return $max_index;
}

# Test cases
my @test_cases = (
    [2, 4, 1, 0],      # Expected output: 1
    [1, 2, 3, 4],      # Expected output: -1
    [5, 1, 2, 3],      # Expected output: 0
    [1],               # Expected output: 0
    [0, 0, 0, 1],      # Expected output: 3
);

foreach my $test (@test_cases) {
    my $result = twice_largest_index(@$test);
    print "Input: \@ints = (@$test)\n";
    print "Output: $result\n\n";
}

