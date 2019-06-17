#!/usr/bin/perl6
use v6;
use Test;

# Challenge #2
# Write a script to demonstrate Mutually Recursive methods. Two methods are mutually recursive if the first method calls the second and the second calls first in turn. Using the mutually recursive methods, generate Hofstadter Female and Male sequences.
#
#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
#  M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.
# F: 1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 13, ... (sequence A005378 in the OEIS)
# M: 0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 12, ... (sequence A005379 in the OEIS)

my $f=join ", ", map { F($_) }, (^21);
is $f,"1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 13", "Hofstadter Female sequence";

my $m=join ", ", map { M($_) }, (^21);
is $m,"0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 12", "Hofstadter Male sequence";


multi F($n where $n==0) { 1 }
multi F($n)             { $n - M( F( $n-1 ) ) }

multi M($n where $n==0) { 0 }
multi M($n) { $n − F( M( $n − 1 ) ) }
