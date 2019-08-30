#!/usr/bin/env perl

# Create a script that prints nth order forward difference series. You
# should be a able to pass the list of numbers and order number as
# command line parameters. Let me show you with an example.
#
# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would
# like to create 1st order forward difference series (Y). So using the
# formula Y(i) = X(i+1) - X(i), we get the following numbers: (9-5),
# (2-9), (8-2), (1-8), (6-1). In short, the final series would be: 4,
# -7, 6, -7, 5. If you noticed, it has one less number than the original
# series. Similary you can carry on 2nd order forward difference series
# like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.
#
# The order is passed as the first parameter to the script, followed
# by the list of items. For example, to compute the first order forward
# difference series of the list above, we'd run
#
#   perl ch-1.pl 1 5 9 2 8 1 6
#   4 -7 6 -7 5
#
# To compute the second order we'd run
#
#   perl ch-1.pl 2 5 9 2 8 1 6
#   -11 13 -13 12

use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);

my ($n, @X) = @ARGV;

my @Y = nth_order_forward_diff($n, @X);
say "@Y";

sub nth_order_forward_diff($n, @X) {
    for (1..$n) {
        my @Y;
        for my $i (0..$#X - 1) {
            $Y[$i] = $X[$i+1] - $X[$i];
        }
        @X = @Y;
    }
    return @X;
}
