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
# Run as: perl ch-2.pl < input-file
#

#
# The challenge isn't clear whether it wants a count of all possible
# numbers which match, or the number of unique numbers. For instance,
# an input of 
#                1232 2
#
# would yield 12 twice. Do we count them both? Or are we supposed to
# only count unique once? The examples are of no help. 
#
# Furthermore, what about leading 0s? An input of
#
#                102 2
#
# yield both 02 and 2. (And something like '100 3' will yield
# 0, 0 and 00).
#
# We've decided to be as inclusive as possible. So
#
#                1232 2
#
# will give 12, 122, 132, 12, 2, 232, 22, 32, and 2, for a total of 9.
#
# and
#                102 2
#
# will give 10, 12, 0, 02, and 2, for a total of 5.
#

#
# Recursive function to count all substrings for which $m is
# a proper divisor.
#
sub substrings ($n, $m, $prefix = -1, $max = $n) {
    if (!length $n) {
        #
        # If $n is empty, we have reached the end of recursion.
        # If $prefix isn't -1, not equal to the full string,
        # and if $m properly divides $prefix, we count $prefix,
        # else, we don't.
        #
        return $prefix > -1   &&
               $prefix < $max &&
               $prefix % $m == 0 ? 1 : 0;
    }
    #
    # Recurse, once by picking up the first character of $n, and
    # once by skipping the first character.
    #
    my $fc   = substr ($n, 0, 1);
    my $next = 10 * ($prefix == -1 ? 0 : $prefix) + $fc;
    substrings (substr ($n, 1), $m, $next,   $max) +
    substrings (substr ($n, 1), $m, $prefix, $max);
}



say substrings split while <>;
