# Create a script that prints nth order forward difference series.
# You should be a able to pass the list of numbers and order number as
# command line parameters. Let me show you with an example.

# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like
# to create 1st order forward difference series (Y).
# So using the formula Y(i) = X(i+1) - X(i), we get the following numbers:
# (9-5), (2-9), (8-2), (1-8), (6-1). In short, the final series would be:
# 4, -7, 6, -7, 5. If you noticed, it has one less number than the
# original series. Similary you can carry on 2nd order forward difference
# series like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.

use strict;
use warnings;
use v5.10;

# we start by teading the list of numbers and the order

my $order = pop @ARGV;    # last command line parameter is requested order

# we are going to define a 2 dimmension array to hold original data and
# calculed differences. [0] index for order is input data by definition

my @differences;

$differences[0] = [@ARGV];    # just copy input to order 0 diff

# now we start calculating differences as many times as $order indicates:

for my $o ( 0 .. $order - 1 ) {

    # we will calculate $o+1 array from $o
    # we will need the amount of elements on current array
    my $osize = @{ $differences[$o] };
    last if $osize < 2;    # cannot calculate more differences
    for my $i ( 0 .. $osize - 2 ) {    # will do $osize - 1 substractions
        $differences[ $o + 1 ][$i] =
          $differences[$o][ $i + 1 ] - $differences[$o][$i];
    }
}

# now we just print requested order
print "$_ " for @{ $differences[$order] };
say '';                                # final "\n"

# example: you can call this script to get the 2nd order difference below like:
# $> perl ch-1.pl 5 9 2 8 1 6 2
#
# and get the corresponding result:
#
# -11 13 -13 12
#
