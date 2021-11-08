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
# Run as: perl ch-1.pl < input-file
#

use List::Util qw [min];
my @ugly   = (1);
my $next_2 =  0;
my $next_3 =  0;
my $next_5 =  0;

#
# We will maintain the following invariants:
#
#     2 * $ugly [$next_2 - 1] <= $ugly [-1] < 2 * $ugly [$next_2]
#     3 * $ugly [$next_3 - 1] <= $ugly [-1] < 3 * $ugly [$next_2]
#     5 * $ugly [$next_5 - 1] <= $ugly [-1] < 5 * $ugly [$next_2]
#
# And since every ugly number (except the first) is either twice an
# ugly number, three times an ugly number, or five times an ugly
# number, the next ugly number will be the minimum of 
# (2 * $ugly [$next_2], 3 * $ugly [$next_3], 5 * $ugly [$next_5]).
#
# We will spend O(1) time per generated ugly number, so our
# program will run in O(N) time, using O(N) memory.
#

while (my $n = <>) {
    while (@ugly < $n) {
        #
        # Calculate the next ugly number.
        #
        push @ugly => min 2 * $ugly [$next_2],
                          3 * $ugly [$next_3],
                          5 * $ugly [$next_5];

        #
        # Update pointers. It could be that more than one pointer needs
        # updating. (This happens if the ugly number generated is
        # divisible by 6, 10, 15, or 30). No pointer ever needs updating twice.
        #
        $next_2 ++ if 2 * $ugly [$next_2] <= $ugly [-1];
        $next_3 ++ if 3 * $ugly [$next_3] <= $ugly [-1];
        $next_5 ++ if 5 * $ugly [$next_5] <= $ugly [-1];
    }
    say $ugly [-1];
}


__END__
