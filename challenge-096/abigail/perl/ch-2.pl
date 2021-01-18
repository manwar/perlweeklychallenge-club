

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util 'min';

#
# This is an implementation of the Wagner Fischer algorithm, which
# calculates the Levenshtein distance.
#
# See https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm
#
sub LevenshteinDistance ($first, $second) {
   ($first, $second) = ($second, $first) if length ($first) <
                                            length ($second);
    my $distance;
    for (my $i = 0; $i <= length ($first); $i ++) {
        for (my $j = 0; $j <= length ($second); $j ++) {
            $$distance [$i] [$j] =
                $j == 0 ? $i
              : $i == 0 ? $j
              : min ($$distance [$i - 1] [$j]     + 1,
                     $$distance [$i]     [$j - 1] + 1,
                     $$distance [$i - 1] [$j - 1] + 
                        (substr ($first,  $i - 1, 1) eq
                         substr ($second, $j - 1, 1) ? 0 : 1))
        }
        #
        # We only need the previous row; this reduces the memory
        # from O (N * M) to O (min (N, M)), where N and M are the
        # lengths of the input strings.
        #
        undef $$distance [$i - 1] if $i;
    }
    $$distance [-1] [-1];
}


say LevenshteinDistance /\S+/g for <>;
