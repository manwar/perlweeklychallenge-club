# TASK #1: Count Set Bits

# You are given a positive number $N. Write a script
# to count the total numbrer of set bits of the binary
# representations of all numbers from 1 to $N and
# return $total_count_set_bit % 1000000007.

# Following you will find a "naive" approach to the challenge
# Note that perl already has the capability to get
# a binary expression of an integer, just using
# the sprintf formatter %b, as in
#
# my $binary_string = sprintf("%b", $number);
#
# you can also  count how many "1"s you have,
# just use ~= tr/1// as a regex and it will return
# a scalar with the amount of substitutions done
# (i.e, number of 1s in the binary representation)
#
# Also we are supposed to truncate every addition to a modulo 1000000007
# integer, probably avoiding any overflow on perl arithmetic
# for 32 bit perls (that number is a prime number offen
# used for that purpose)
#
# So our script will just be:

use strict;
use warnings;
use v5.20;

my $big_prime           = 1_000_000_007;
my $total_count_set_bit = 0;

for my $n (1 .. shift) {    # or $ARGV[0]
  $total_count_set_bit += sprintf("%b", $n) =~ tr/1//;
  $total_count_set_bit %= $big_prime;
}

say $total_count_set_bit;
