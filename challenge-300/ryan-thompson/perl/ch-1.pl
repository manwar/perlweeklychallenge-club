#!/usr/bin/env perl
#
# Returns the count of beautiful arrangements of numbers 1..$int
# For each permutation P, P is beautiful iff all elements of P
# match at least one of the following conditions:
#   1. P[i] is divisible by i
#   2. i is divisible by P[i]
# Permutation indices are 1-based.

use 5.038;
use Algorithm::Permute;

sub beautiful($int) {
    my $perms = Algorithm::Permute->new([1..$int]);
    my $count = 0;

P:  while (my @P = $perms->next) {
        $P[$_-1] % $_ and $_ % $P[$_-1] and next P for 1..$int;
        $count++;
    }
    $count;
}

# The algorithm is O(n!), so I suggest a small $n :-)
my $n = shift or die "Usage: $0 <+ve integer>\n";
say "beautiful($n) = " . beautiful($n);
