#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Utils qw(ceil floor);

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [--] [N...]

-examples
    run some examples
 
N...
    Calculate the five-number summary over the given numbers.

EOS


### Input and Output

say "@{[fivenum(@ARGV)]}";


### Implementation

# According to Wiki (https://en.wikipedia.org/wiki/Quartile), there is
# no agreement about the method to calculate the quartiles of discrete
# distributions.  For aesthetic reasons I prefer "Method 2" because the
# five-number summary for a distribution of five numbers consist of
# these five numbers.  The characteristic of "Method 2" is the inclusion
# of the median in both, the upper and the lower part for the
# determination of the first and third quartile in case of odd-sized
# samples.
# We may take the value of a non-integer index of an array as the mean
# of the surrounding values.  No weighting is required here, as all
# indices will be multiples of 1/2.
# If the sample size is odd, the median index is an integer and thus the
# median is naturally part of the lower and the upper half of the sample
# as in "Method 2".  The 1/4 and 3/4 indices thus will give the correct
# index for the first and third quartile.  Otherwise in the case of an
# even sample size, the median index is in the middle between two
# integers and the 1/4 and 3/4 indices are therefore off by ±1/4.
#
sub fivenum {
    # numbers need to be sorted.
    my @n = sort {$a <=> $b} @_;

    # non-integer index around the first quartile.
    my $q = $#n / 4;
    # Offset for the exact (non-integer) indices of the first
    # and third quartile.
    my $o = ($#n % 2) / 4;
    # zeroth (min), first, second (median), third and fourth (max)
    # quartile. Interpolated if necessary by taking the mean of the
    # surrounding values for non-integer indices.
    map +($n[floor $_] + $n[ceil $_]) / 2,
        0, $q - $o, $#n / 2, 3 * $q + $o, $#n;
}


### Examples and tests

sub run_tests {
    is [fivenum(0, 0, 1, 2, 63, 61, 27, 13)],
        [0, 0.5, 7.5, 44, 63], 'example from Wiki "Five-number summary';

    is [fivenum(6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49)],
        [6, 25.5, 40, 42.5, 49], 'example 1 from Wiki "Quartile"';


    is [fivenum(7, 15, 36, 39, 40, 41)],
        [7, 15, 37.5, 40, 41], 'example 2 from Wiki "Quartile"';

    is [fivenum(3, 5, 8, 13, 21)],
        [3, 5, 8, 13, 21], "five numbers";

    done_testing;
    exit;
}
