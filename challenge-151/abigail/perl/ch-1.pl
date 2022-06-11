#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: perl ch-1.pl < input-file
#

#
# We'll store the tree in a triangular 2-d array, with
# the children on node on position [$d, $k] on positions
# [$d + 1, 2 * $k] and [$d + 1, 2 * $k + 1].
#
# Finding the first node without children is trivial.
#
TREE: while (<>) {
    chomp;
    my @tree = map {[map {$_ ne '*'} /\S+/g]} split /\|/;
    foreach my $d (keys @tree) {
        foreach my $i (keys @{$tree [$d]}) {
            if ($tree [$d] [$i] && !$tree [$d + 1] [2 * $i]
                                && !$tree [$d + 1] [2 * $i + 1]) {
                say $d + 1;
                next TREE;
            }
        }
    }
}
