#!/usr/bin/perl
use strict;
use warnings;

use POSIX qw(floor);

sub divisible_average {

    my @arr_1 = @_;

    # Step 1: Filter all even integers that are divisible by 3;
    #         in other words, filter all integers that are divisible by
    #         both 2 and 3, or simply, all integers that are divisible by 6.
    my @arr_2 = grep { $_ % 6 == 0 } @arr_1;

    my $result = 0;

    if (@arr_2) {

        # Step 2: calculate average
        my $sum = 0;
        $sum += $_ for @arr_2;

        my $average = $sum / scalar @arr_2;

        # Step 3: rounding to the nearest integer
        $result = floor($average + 0.5);
    }

    return $result;
}

# Tests

my @arr;

# Example 1
@arr = (18, 5, 7, 11);
print "Result:", divisible_average(@arr), "\n"; # 18

# Example 2
@arr = (6, 12, 18, 24, 30, 40);
print "Result:", divisible_average(@arr), "\n"; # 18

# Example 3
@arr = (3, 9, 15, 21, 27);
print "Result:", divisible_average(@arr), "\n"; # 0

# Example 4
@arr = (6, 12, 14, 20);
print "Result:", divisible_average(@arr), "\n"; # 9

# Example 5
@arr = (6, 6, 6, 12, 12);
print "Result:", divisible_average(@arr), "\n"; # 8
