#!/usr/bin/perl
use strict;
use warnings;

sub sorted_squares {
    my ($aref) = @_;
    my @squares = map { $_ * $_ } @$aref;
    return sort { $a <=> $b } @squares;
}


# Tests

my @list;

# Example 1
@list = (-2, -1, 0, 3, 4);
print "(" . join(", ", sorted_squares(\@list)) . ")\n"; # Output: (0, 1, 4, 9, 16)

# Example 2
@list = (5, -4, -1, 3, 6);
print "(" . join(", ", sorted_squares(\@list)) . ")\n"; # Output: (1, 9, 16, 25, 36)
