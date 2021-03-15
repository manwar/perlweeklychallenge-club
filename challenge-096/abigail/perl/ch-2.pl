#!/opt/perl/bin/perl

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util 'min';

#
# The challenge isn't quite clear on whether we should output a number
# (the minimal number of operations required), or the actual operations.
# The examples show both -- but separated by a blank line. Previous
# challenges typically use a blank line to separate the required output
# from the explaination on why that it is the correct answer.
#
# We're opting to only print the number of operations, not the actual
# operations.
#

#
# This is an implementation of the Wagner Fischer algorithm, which
# calculates the Levenshtein distance.
#
# See https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm
#
sub LevenshteinDistance ($first, $second) {
    my $distance;
    for (my $i = 0; $i <= length ($first); $i ++) {
        for (my $j = 0; $j <= length ($second); $j ++) {
            $$distance [$i] [$j] =
                $i == 0 || $j == 0 ? $i + $j
              : min ($$distance [$i - 1] [$j]     + 1,
                     $$distance [$i]     [$j - 1] + 1,
                     $$distance [$i - 1] [$j - 1] + 
                        (substr ($first,  $i - 1, 1) eq
                         substr ($second, $j - 1, 1) ? 0 : 1))
        }
        #
        # We only need the previous row; this reduces the memory
        # from Theta (N * M) to O (N + M), where N and M are the
        # lengths of the input strings.
        #
        undef $$distance [$i - 1] if $i;
    }
    $$distance [-1] [-1];
}


say LevenshteinDistance /\S+/g for <>;
