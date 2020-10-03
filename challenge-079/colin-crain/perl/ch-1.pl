#! /opt/local/bin/perl
#
#       count_set_match.pl
#
#       TASK #1 › Count Set Bits
#         Submitted by: Mohammad S Anwar
#         You are given a positive number $N.
# 
#         Write a script to count the total number of set bits of the binary
#         representations of all numbers from 1 to $N and return
#         $total_count_set_bit % 1000000007.
# 
#         Example 1:
#         Input: $N = 4
# 
#         Explanation: First find out the set bit counts of all numbers 
#             i.e. 1, 2, 3 and 4.
# 
#             Decimal: 1
#             Binary: 001
#             Set Bit Counts: 1
# 
#             Decimal: 2
#             Binary: 010
#             Set Bit Counts: 1
# 
#             Decimal: 3
#             Binary: 011
#             Set Bit Counts: 2
# 
#             Decimal: 4
#             Binary: 100
#             Set Bit Counts: 1
# 
#             Total set bit count: 1 + 1 + 2 + 1 = 5
# 
#         Output: Your script should print `5` as `5 % 1000000007 = 5`.
#         Example 2:
#         Input: $N = 3
# 
#         Explanation: First find out the set bit counts of all numbers 
#             i.e. 1, 2 and 3.
# 
#             Decimal: 1
#             Binary: 01
#             Set Bit Count: 1
# 
#             Decimal: 2
#             Binary: 10
#             Set Bit Count: 1
# 
#             Decimal: 3
#             Binary: 11
#             Set Bit Count: 2
# 
#             Total set bit count: 1 + 1 + 2 = 4
# 
#         Output: Your script should print `4` as `4 % 1000000007 = 4`.
# 
#         method:
#             The way I see it, there are three parts to this task. Over a loop
#             of values, we need to first create a binary representation of a
#             number, then count and sum the 1s present in those values. For the
#             third and seemingly, puzzlingly unrelated part, we then modulo the
#             total by one billion and seven.
# 
#             In weeks past, we've found easy ways to convert decimal to binary.
#             For the counting the 1s step, this is the same as summing every
#             digit, as these, being binary, are only going to be either 1 or 0.
#             Breaking the digit string into a list of elements and then summing
#             these accomplishes this well; after this step the sum is added to
#             a running total for the sequence of 1 up to the target value.
# 
#             As for the modulo phase, a little explanation is in order. The
#             value 1000000007 is ultimately arbitrary, and is selected because
#             it:
#     
#                 1. is large, but not too large, and
#                 2. is prime
#     
#             Beyond these criteria, there is no meaning behind that specific
#             choice of number, and 1,000,000,033 would do just as well, or
#             2,000,000,033. Speaking to the first point, what this selection
#             does is produce a verifiable, reproducable result that fits into
#             common integer data types without any risk of overflow.
# 
#             This can even be done at every step of a calculation involving
#             very very large numbers, constructing the correct modulo result
#             without ever exceeding the range of a 32-bit integer. But then
#             again there is no requirement here either to process an unusually
#             big range or for that matter work properly on 32-bit machines. So
#             even should we wish to include values past 2^32 in our
#             intermediary steps, the 64-bit norm these day gives us
#             considerably more range. 
# 
#             So we're not going to bother to do that. I do wonder if anyone
#             will. 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $input = shift // 100000;
my $tot;

for my $i (1..$input) {
    my $bin = sprintf "%b", $i;
    my $j = length $bin;
    while (--$j >= 0 ) {
        substr( $bin, $j, 1 ) and $tot++;
    }
}
my $out = $tot % 1000000007;

say "out:  $out";
