#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: perl ch-2.pl < input-file
#
# Each line of input is taken as a set of two rectangles, and consists
# of 8 numbers: first the corners of the first rectangle, than the
# corners of the second rectangle.
#
# We calculate the total area as the sum of the areas of each
# rectangle, minus the area of the overlap. 
# The area of a rectangle is the product of the absolute difference of the
# x-coordinates and the absolute difference of the y-coordinates.
# The absolute difference of two numbers can be calculated by subtracting
# the minimum of the two from the maximum of the two.
# To calculate the area of the overlap, we multiply the overlap in the
# x-dimension, and the overlap in the y-dimension. To get the overlap
# in the x-dimension, we take the minimum of the max x-values of both
# rectangles, and subtract the maximim of the min x-values of both
# rectangles. If this value is less than 0, the overlap is 0.
# For the overlap in the y-dimension, we do the same with the y values.
#
# min (@F [0, 2]):  Smallest x-value for first  rectangle
# max (@F [0, 2]):  Largest  x-value for first  rectangle
# min (@F [1, 3]):  Smallest y-value for first  rectangle
# max (@F [1, 3]):  Largest  y-value for first  rectangle
# min (@F [4, 5]):  Smallest x-value for second rectangle
# max (@F [4, 5]):  Largest  x-value for second rectangle
# min (@F [6, 7]):  Smallest y-value for second rectangle
# max (@F [6, 7]):  Largest  y-value for second rectangle
#
# See https://math.stackexchange.com/questions/99565/
#             simplest-way-to-calculate-the-intersect-area-of-two-rectangles
#

use List::Util qw [min max];

while (<>) {my @F = split; # Mimic -a

    say        +(max (@F [0, 2]) - min (@F [0, 2]))  *
                (max (@F [1, 3]) - min (@F [1, 3]))  +
                (max (@F [4, 6]) - min (@F [4, 6]))  *
                (max (@F [5, 7]) - min (@F [5, 7]))  -   
    max (0, min (max (@F [0, 2]),  max (@F [4, 6]))  -
            max (min (@F [0, 2]),  min (@F [4, 6]))) *  
    max (0, min (max (@F [1, 3]),  max (@F [5, 7]))  -
            max (min (@F [1, 3]),  min (@F [5, 7])));

}

__END__
