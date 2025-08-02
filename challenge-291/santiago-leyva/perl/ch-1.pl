#!/bin/perl/env

=begin
You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst all the possible ones.

A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] == ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].

If MI == 0, the left side sum is considered to be 0. Similarly,
if MI == ints.length - 1, the right side sum is considered to be 0.
Return the leftmost MI that satisfies the condition, or -1 if there is no such index.

Example 1
Input: @ints = (2, 3, -1, 8, 4)
Output: 3

The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
The sum of the numbers after index 3 is: 4 = 4
Example 2
Input: @ints = (1, -1, 4)
Output: 2

The sum of the numbers before index 2 is: 1 + -1 = 0
The sum of the numbers after index 2 is: 0
Example 3
Input: @ints = (2, 5)
Output: -1

There is no valid MI.

=cut

use strict;
use warnings;
use Test::More tests => 3;
use POSIX qw(floor);


my @ints = ([2, 3, -1, 8, 4],[1, -1, 4],[2, 5]);

foreach(@ints){
    my @array = @$_;
    my $result = findIndex(\@array);
    print $result."\n";
}

sub findIndex {

    my $input = shift;
    my @A = @$input;
    my $n = scalar @A;
    my $total_sum = 0;
    $total_sum += $_ for @A;

    my $left_sum = 0;
    
    for my $i (0 .. $n - 1) {

        my $right_sum = $total_sum - $left_sum - $A[$i];

        if ($left_sum == $right_sum) {
            return $i;  
        }
        
        $left_sum += $A[$i];
    }

    return -1;  # Return -1 if no index found
}


my @example1 = (2, 3, -1, 8, 4);
my @example2 = (1, -1, 4);
my @example3 = (2, 5);

is(findIndex(\@example1),3);
is(findIndex(\@example2),2);
is(findIndex(\@example3),-1);