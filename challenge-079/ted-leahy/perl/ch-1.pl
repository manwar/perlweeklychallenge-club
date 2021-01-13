# # Count Set Bits # #
# - You are given a positive number $N.
# - Write a script to count the total numbrer of set bits of the binary representations
#   of all numbers from 1 to $N and return $total_set_bit_count % 1000000007.
# #

use strict;
use warnings;
use feature 'say';

my ($N) = @ARGV;
my $total_set_bit_count = 0;

foreach my $n (1..$N) {
    # Convert to binary
    my $binary_n = sprintf("%b", $n);
    # Count the number of set bits ('1's)
    my $set_bit_count = ($binary_n =~ tr/1//);

    $total_set_bit_count += $set_bit_count;
}

say $total_set_bit_count % 1000000007;

1;