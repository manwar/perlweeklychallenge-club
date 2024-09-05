#!/usr/bin/perl
use strict;
use warnings;

sub no_connection {

    # create strings directly from the array of pairs using map and join together
    my $r1 = join('', map { $_->[0] } @_);
    my $r2 = join('', map { $_->[1] } @_);

    # remove each character in $r1 from $r2
    $r2 =~ s/[$r1]//g;

    return ($r2);
}

# Tests
my @routes;

# Example 1
@routes = (["B", "C"], ["D", "B"], ["C", "A"]);
print(no_connection(@routes), "\n"); # Output: A

# Example 2
@routes = (["A", "Z"]);
print(no_connection(@routes), "\n"); # Output: Z
