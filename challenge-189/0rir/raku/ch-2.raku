#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
189-2: Array Degree            Submitted by: Mohammad S Anwar

Given an array of 2 or more non-negative integers, find the smallest slice,
i.e. contiguous subarray of the original array, having the degree of the given array.

The degree of an array is the maximum frequency of an element in the array.

Example 1
Input: @array = (1, 3, 3, 2)
Output: (3, 3)

The degree of the given array is 2.
The possible subarrays having the degree 2 are as below:
(3, 3)
(1, 3, 3)
(3, 3, 2)
(1, 3, 3, 2)

And the smallest of all is (3, 3).
Example 1
Input: @array = (1, 3, 3, 2)
Output: (3, 3)
Example 2
Input: @array = (1, 2, 1, 3)
Output: (1, 2, 1)
Example 3
Input: @array = (1, 3, 2, 1, 2)
Output: (2, 1, 2)
Example 4
Input: @array = (1, 1, 2, 3, 2)
Output: (1, 1)
Example 5
Input: @array = (2, 1, 2, 1, 1)
Output: (1, 2, 1, 1)

=end comment

sub shortest-degree-slice( @list --> Array ) {
    my @by-ct = @list.BagHash.antipairs;
    my $most-common-qty = max( map( *.key, @by-ct));
    my @common-value = map( *.value, grep( *.key == $most-common-qty, @by-ct));
    my ($head, $tail) = 0, @list.end;
    for @common-value.reverse -> $e {
        my $hd = @list.first( * == $e, :k);
        my $tl = @list.first( * == $e, :end, :k);
        ($head, $tail) = ($hd, $tl) if $tail - $head ≥  $tl - $hd;
    }
    @list[ $head .. $tail].Array;
}

sub MAIN() {
    my @Test =
        { array => (1, 2, 1, 2, 1, 1), :exp(1, 2, 1, 2, 1, 1), },
        { array => (1, 3, 3, 2), :exp(3, 3), },
        { array => (1, 2, 1, 3), :exp(1, 2, 1), },
        { array => (1, 3, 2, 1, 2), :exp(2, 1, 2), },
        { array => (1, 1, 2, 3, 2), :exp(1, 1), },
        { array => (2, 1, 2, 1, 1), :exp(1, 2, 1, 1), },
        { array => (2, 2, 1, 1, 3), :exp(2, 2), },
    ;

    plan +@Test;
    for @Test -> %t {
        is shortest-degree-slice( %t<array>), %t<exp>, "%t<array> -> %t<exp>";
    }
    done-testing;
    exit;
}
