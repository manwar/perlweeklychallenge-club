#!/usr/bin/perl

# Challenge 013
#
# Challenge #2
# Write a script to demonstrate Mutually Recursive methods. Two methods are
# mutually recursive if the first method calls the second and the second calls
# first in turn. Using the mutually recursive methods, generate Hofstadter
# Female and Male sequences.
#
#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
#  M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.

use strict;
use warnings;
use 5.030;

sub F {
    my($n) = @_;
    return 1 if $n==0;
    return $n - M( F($n - 1) );
}

sub M {
    my($n) = @_;
    return 0 if $n==0;
    return $n - F( M($n - 1) );
}

my $N = shift || 21;

say "F: ", join(", ", map {F($_)} 0..$N-1), ", ...";
say "M: ", join(", ", map {M($_)} 0..$N-1), ", ...";
