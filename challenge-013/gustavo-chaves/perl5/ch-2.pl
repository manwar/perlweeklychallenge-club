#!/usr/bin/env perl

# Write a script to demonstrate Mutually Recursive methods. Two methods are
# mutually recursive if the first method calls the second and the second calls
# first in turn. Using the mutually recursive methods, generate Hofstadter
# Female and Male sequences
# (https://en.wikipedia.org/wiki/Hofstadter_sequence#Hofstadter_Female_and_Male_sequences).

use 5.026;
use strict;
use autodie;
use warnings;
use Memoize;

my $n = shift or die "Usage: $0 N";

$n >= 0 or die "N must be non-negative\n";

memoize('F');
sub F {
    my ($n) = @_;
    if ($n == 0) {
        return 1;
    } else {
        return $n - M(F($n-1));
    }
}

memoize('M');
sub M {
    my ($n) = @_;
    if ($n == 0) {
        return 0;
    } else {
        return $n - F(M($n-1));
    }
}

print 'F:';
foreach my $i (0 .. $n) {
    print ' ', F($i);
}
print "\n";

print 'M:';
foreach my $i (0 .. $n) {
    print ' ', M($i);
}
print "\n";
