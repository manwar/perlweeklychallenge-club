#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-17
# Week: 013
# Challenge: #2
#
# Write a script to demonstrate Mutually Recursive methods. Two methods
# are mutually recursive if the first method calls the second and the
# second calls first in turn. Using the mutually recursive methods,
# generate Hofstadter Female and Male sequences.
#
# F ( 0 ) = 1   ;   M ( 0 ) = 0
# F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
# M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.

use strict;
use warnings;

my $n = 20;

print "female sequence: ";
for ( 0 .. $n ) {
    print &f($_) . ", ";
}
print "...\n";

print "  male sequence: ";
for ( 0 .. $n ) {
    print &m($_) . ", ";
}
print "...\n";

sub f {
    my $n = shift;
    if ( $n == 0 ) {
        return 1;
    }
    elsif ( $n > 0 ) {
        return ( $n - &m( &f( $n - 1 ) ) );
    }
}

sub m {
    my $n = shift;
    if ( $n == 0 ) {
        return 0;
    }
    elsif ( $n > 0 ) {
        return ( $n - &f( &m( $n - 1 ) ) );
    }
}