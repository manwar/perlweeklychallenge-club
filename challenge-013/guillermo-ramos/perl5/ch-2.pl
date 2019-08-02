#!/usr/bin/env perl
#
# Write a script to demonstrate Mutually Recursive methods. Two methods are
# mutually recursive if the first method calls the second and the second calls
# first in turn. Using the mutually recursive methods, generate Hofstadter
# Female and Male sequences.
# (https://en.wikipedia.org/wiki/Hofstadter_sequence#Hofstadter_Female_and_Male_sequences)
################################################################################

use strict;
use warnings;

use Memoize qw<memoize>;

# Cache the results of previous computations
memoize('M');
memoize('F');

sub M {
    my $n = shift;
    return $n == 0
        ? 0
        : $n - F(M($n-1));
}

sub F {
    my $n = shift;
    return $n == 0
        ? 1
        : $n - M(F($n-1));
}

die "Usage: $0 <iterations>\n" unless @ARGV == 1;

print "M\tF\n-\t-\n";
foreach my $n (0 .. shift) {
    printf "%d\t%d\n", M($n), F($n);
}
