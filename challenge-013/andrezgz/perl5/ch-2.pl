#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-013/
# Challenge #2
# Write a script to demonstrate Mutually Recursive methods.
# Two methods are mutually recursive if the first method calls the second and the second calls first in turn.
# Using the mutually recursive methods, generate Hofstadter Female and Male sequences.
# https://en.wikipedia.org/wiki/Hofstadter_sequence#Hofstadter_Female_and_Male_sequences
#
# F ( 0 ) = 1   ;   M ( 0 ) = 0
# F ( n ) = n - M ( F ( n - 1 ) ) , n > 0
# M ( n ) = n - F ( M ( n - 1 ) ) , n > 0.

use strict;
use warnings;

my $last_term = $ARGV[0] ? $ARGV[0]-1 : 20;

print 'F: '.join(',', map { F($_) } (0 .. $last_term) ).$/;
print 'M: '.join(',', map { M($_) } (0 .. $last_term) ).$/;


sub F {
    my ($n) = @_;
    return 1 unless $n;
    return $n - M(F($n-1));
}

sub M {
    my ($n) = @_;
    return 0 unless $n;
    return $n - F(M($n-1));
}
