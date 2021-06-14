#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl [sqrt | count | search | preproces ] < input-file
#
# We will be using one of four different ways to check whether the sum
# of the squares is a square:
#
#  - sqrt:        Use sqrt () to get the square root of the sum of squares;
#                 we round this to an integer and square it, and check whether
#                 we have the same number. This is the fastest way, but it
#                 requires us to deal with floating point numbers and rounding
#                 errors. (This will be the default if no argument is given).
#  - count:       We'll start counting from 1, and square the numbers.
#                 If at one point the square equals the sum of squares,
#                 we have success. If we exceed the sum of squares without
#                 hitting it, the sum of squares isn't a perfect square.
#                 This sounds inefficient, but the sum of squares is at
#                 most 81 * N, where N indicates the number of input digits.
#                 This means we at most have to check 9 * sqrt (N) numbers,
#                 so its running time is O (sqrt (N)), which is far less
#                 than calculating the sum of squares, which is O (N).
#   - search:     First use a doubling method to find a number X such that
#                 X * X is greater than the sum of squares. Then use binary
#                 search to find out whether the sum of squares is a square.
#                 The running time will be O (log sqrt (N)), also far less
#                 than calculating the sum of squares.
#   - preprocess: Calculate the first 9000 squares. Then we can do an O (1)
#                 lookup. 9000 squares will work for all numbers up to one
#                 million digits (and for many, many, more numbers).
#
use List::Util qw [sum];

my $TYPE_SQRT       = 0;
my $TYPE_COUNT      = 1;
my $TYPE_SEARCH     = 2;
my $TYPE_PREPROCESS = 3;

my $type = $TYPE_SQRT;
if (@ARGV) {
    my $arg = shift;
    if ($arg eq 'count')      {$type = $TYPE_COUNT}
    if ($arg eq 'search')     {$type = $TYPE_SEARCH}
    if ($arg eq 'preprocess') {$type = $TYPE_PREPROCESS}
}

my %squares;
if ($type == $TYPE_PREPROCESS) {
    %squares = map {$_ * $_ => 1} 1 .. 9000;
}

#
# Print 1 if the squares of the digits sum to a perfect square, 0 otherwise.
#
while (<>) {
    #
    # Calculate the sum of the squares of the digits.
    #
    my  $sum_of_squares = sum map {$_ * $_} /[1-9]/g;  # Ignore 0s

    my $is_square;
    if ($type == $TYPE_SQRT) {
        # Is it a perfect square? (Take care of rounding errors).
        $is_square = $sum_of_squares == int (.5 + sqrt $sum_of_squares) ** 2;
    }
    if ($type == $TYPE_COUNT) {
        my $root = 0;
        $root ++ while $root * $root < $sum_of_squares;
        $is_square = $sum_of_squares == $root * $root;
    }
    if ($type == $TYPE_SEARCH) {
        my $root_min = 0;
        my $root_max = 1;
        $root_max *= 2 while $root_max * $root_max < $sum_of_squares;
        while ($root_min < $root_max) {
            my $root_mid = int (($root_min + $root_max) / 2);
            my $square_mid = $root_mid * $root_mid;
            if ($square_mid == $sum_of_squares) {
                $is_square = 1;
                last;
            }
            if ($square_mid < $sum_of_squares) {
                $root_min = $root_mid + 1;
            }
            else {
                $root_max = $root_mid;
            }
        }
    }
    if ($type == $TYPE_PREPROCESS) {
        $is_square = $squares {$sum_of_squares};
    }

    say $is_square ? 1 : 0;
}
