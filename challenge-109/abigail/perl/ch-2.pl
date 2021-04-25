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
# First note that due to symmetry, there cannot be a unique solution [1].
# If
#
#      (a, b, c, d, e, f, g) = (x_1, x_2, x_3, x_4, x_5, x_6, x_7)
#
# is a solution, then
#
#      (a, b, c, d, e, f, g) = (x_7, x_6, x_5, x_4, x_3, x_2, x_1)
#
# must be a solution as well.
#
# For instance, the given example has 8 solutions, 4 of which are
# mirror images.
#
# [1] This assumes no duplicate numbers in the input. Clearly, a
#     solution where a == g, b == f, and c == e doesn't give a
#     different solution when mirrorred. (For instance, if all 
#     numbers are 0, there is only one solution).

#
#
# It's easy to brute force this. There are a mere 5040 permutations
# of the seven numbers; it would be hard to find an environment
# where it takes more than a few milliseconds to try all permutations.
#
# We can improve the brute force a little, by determining early we're
# on a wrong path. For instance, once we have picked an a, b, c, and d,
# we can check whether a + b == b + c + d. If not, we don't have to
# continue trying values for e, f, and g.
#
# However, that's not the way we go. We will first do some analysis.
# Let the sum of each box be N. Then we have:
#
#   N = a + b        (1)
#   N = b + c + d    (2)
#   N = d + e + f    (3)
#   N = f + g        (4)
#
# For (1) and (2), we get:
#
#   a + b = b + c + d  =>
#   a     =     c + d  =>
#   a - c =         d
#
# In the same way, (3) and (4), we get:
#
#   g + f = f + e + d  =>
#   g     =     e + d  =>
#   g - e =         d
#
# This leads to the following algorithm:
# 
#   - Calculate the differences between all pairs (7 * 6 == 42 pairs)
#   - Find all numbers n from the input array for which there are at
#     least two pairs giving this difference, under the condition n
#     is not part of such a pair. (Note that if the input contains
#     two or more of the same number, for this purpose, we treat those
#     numbers to be different). These numbers will be our candidate for d.
#   - Of the list of differences equalling d, consider each pair.
#     Eliminate pairs where the same number appears in each. The first
#     difference gives candidates for a and c; the second gives candidates
#     for g and e. (Swapping them leaves to a symmetric solution).
#   - We now have candidates for a, c, d, e, and g. This leaves two
#     numbers for b and c.
#   - Try both, and check whether a + b == b + c + d == d + e + f == f + g.
#
# For the given example, this means we only try 32 permutations,
# giving us 4 different solutions (the other 4 can be found by
# reversing the numbers).
#
# We are not making any assumptions on the sign of the input numbers;
# our algorithm works fine if the input contains negative numbers.
#
# We will also print all solutions (including the symmetric ones)
#

while (<>) {
    my @numbers = split;

    #
    # For each of the numbers n present in @numbers, find all pairs
    # of numbers whose difference equals n. We will have a data structure
    # '%differences' keyed by the numbers in @numbers; values are
    # two element arrays of *indices*, where the differences of the
    # numbers with those indices are the key.
    #
    my %differences = map {$_ => []} @numbers;

    #
    # Find all the differences, and store them in %differences.
    # We do *not* need to store any pair whose difference is
    # not in @numbers.
    #
    for (my $x = 0; $x < @numbers; $x ++) {
        for (my $y = $x + 1; $y < @numbers; $y ++) {
            my $diff = $numbers [$x] - $numbers [$y];
            push @{$differences { $diff}} => [$x, $y] if $differences { $diff};
            push @{$differences {-$diff}} => [$y, $x] if $differences {-$diff};
        }
    }

    #
    # Now, iterate over the numbers d in @numbers, with index d_i, and for
    # each d, iterate over all pairs of differences equal to d. Only consider
    # pairs where all indices are different, and different from d_i.
    #
    for (my $d_i = 0; $d_i < @numbers; $d_i ++) {
        my $d = $numbers [$d_i];
        my @diffs = @{$differences {$d}};

        #
        # Now, find two pairs where all indices are different.
        #
        for (my $x = 0; $x < @diffs; $x ++) {
            #
            # Ignore a difference involving d_i.
            #
            next if $diffs [$x] [0] == $d_i ||
                    $diffs [$x] [1] == $d_i;   
            for (my $y = $x + 1; $y < @diffs; $y ++) {
                #
                # Second difference cannot involve the number at d_i,
                # and the indices involved in the second difference
                # must be different from the first difference.
                #
                next if $diffs [$y] [0] == $d_i            ||
                        $diffs [$y] [1] == $d_i            ||   
                        $diffs [$x] [0] == $diffs [$y] [0] ||
                        $diffs [$x] [0] == $diffs [$y] [1] ||
                        $diffs [$x] [1] == $diffs [$y] [0] ||
                        $diffs [$x] [1] == $diffs [$y] [1];

                #
                # W.l.o.g. we can now assume $diffs [$x] are
                # the indices for $a and $c, and $diffs [$y]
                # are the indices for $g and $e.
                #
                my ($a_i, $c_i) = @{$diffs [$x]};
                my ($g_i, $e_i) = @{$diffs [$y]};

                #
                # Find the unused indices
                #
                my %indices = map {$_ => 1} keys @numbers;
                delete $indices {$_} for $a_i, $c_i, $d_i, $e_i, $g_i;

                #
                # This leaves two indices for $b and $e.
                # Try them both.
                #
                my $left = [keys %indices];
                foreach my $try ($left, [reverse @$left]) {
                    my ($b_i, $f_i) = @$try;

                    #
                    # Do we have a winner?
                    #
                    next unless           $numbers [$a_i] + $numbers [$b_i] ==
                        $numbers [$b_i] + $numbers [$c_i] + $numbers [$d_i] ==
                        $numbers [$d_i] + $numbers [$e_i] + $numbers [$f_i] ==
                                          $numbers [$f_i] + $numbers [$g_i];

                    #
                    # Print result, and the reverse, so we get all
                    # possible solutions.
                    #
                    my @solution =
                       @numbers [$a_i, $b_i, $c_i, $d_i, $e_i, $f_i, $g_i];

                    local $, = " ";
                    say         @solution;
                    say reverse @solution;
                }
            }
        }
    }
}
