#!/usr/bin/env perl
use v5.40;

use Test::More;

=head1 Perl Weekly Challenge 301 Task 2

You are given an array of integers, @ints.

Write a script to return the sum of Hamming distances between all the pairs of the integers in the given array of integers.

The Hamming distance between two integers is the number of places in which their binary representations differ.

Example 1

Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.

Example 2

Input: @ints = (4, 14, 4)
Output: 4

=head2 perl pack/unpack and xor

We xor two numbers to have 1 on ever byte that differs.
Then we use of the pack and unpack functions to convert number to unsigned 32bits network
 (big endian) order (N), and then convert to a bit string (b)
At the end tr will give you the total number of 1 in the bit string which equals to the Hamming Distance

=cut

sub hamming_distance($a, $b) {
    my $xor_unsigned_32bits = pack("N",$a^$b);
    my $xor_bit_string = unpack("b*", $xor_unsigned_32bits);
    my $distance = $xor_bit_string =~ tr/1/1/;
    return $distance;
}

sub total_hamming_distance(@ints) {
    my $size = scalar @ints;
    my $total = 0;
    for ( my $i = 0; $i < $size; $i++ ) {
        for ( my $j = $i+1; $j < $size; $j++) {
            $total += hamming_distance($ints[$i], $ints[$j]);
        }
    }
    return $total;
}

is( hamming_distance(4, 14), 2, "Hamming Distance Test 1");
is( hamming_distance(4, 2), 2, "Hamming Distance Test 2");
is( hamming_distance(14, 2), 2, "Hamming Distance Test 3");
is( hamming_distance(4, 4), 0, "Hamming Distance Test 4");

is( total_hamming_distance(4, 14, 2), 6, "Example 1");
is( total_hamming_distance(4, 14, 4), 4, "Example 2");

done_testing;
