# Write a script to demonstrate Mutually Recursive methods.
# Two methods are mutually recursive if the first method
# calls the second and the second calls first in turn.
# Using the mutually recursive methods, generate
# Hofstadter Female and Male sequences.

#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
#  M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.
use strict;
use warnings;
use v5.10;

# we just write the required functions as Perl subs:

sub F {
    my $n = shift;
    return $n ? $n - M( F( $n - 1 ) ) : 1;
}

sub M {
    my $n = shift;
    return $n ? $n = $n - F( M( $n - 1 ) ) : 0;
}

# now we can use those functions to show how those sequences start:

print "F: ";
print F($_), ', ' for 0 .. 19;
print "...\n";
print "M: ";
print M($_), ', ' for 0 .. 19;
print "...\n";
