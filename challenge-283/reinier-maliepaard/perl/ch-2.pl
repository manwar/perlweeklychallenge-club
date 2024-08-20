#!/usr/bin/perl
use strict;
use warnings;

=begin
Let's use my favorite Statistics module again!
=cut

use Statistics::Frequency;

sub digit_count_value {

    my @ints = @_;
    # create a new Statistics::Frequency object
    my $freq  = Statistics::Frequency->new(@ints);

    for (my $i = 0; $i < scalar(@ints); $i++) {
        # $freq->frequency($i) returns the frequency
        # only if $i is element of @ints
        if (grep( /^$i$/, @ints )) {
            return("false") if($freq->frequency($i) != $ints[$i]);
        } else {
            # if $i is not an element of @ints, $ints[$i] should be 0
            return("false") if ($ints[$i] != 0);
        }
    }
    return("true");
}

# Tests

my @ints;

# Example 1
@ints = (1, 2, 1, 0);
print(digit_count_value(@ints), "\n"); # Output: true

# Example 2
@ints = (0, 3, 0);
print(digit_count_value(@ints), "\n"); # Output: false

# Example 3
@ints = (2, 0, 2, 0);
print( digit_count_value(@ints), "\n"); # Output: true

# Example 4
@ints = (2, 1, 2, 0, 0);
print( digit_count_value(@ints), "\n"); # Output: true

# Example 5
@ints = (2, 1, 0, 0, 2);
print( digit_count_value(@ints), "\n"); # Output: false

# Example 6
@ints = (2, 1, 1, 0, 0);
print( digit_count_value(@ints), "\n"); # Output: false

# Example 7
@ints = (0, 3, 2, 0, 1);
print( digit_count_value(@ints), "\n"); # Output: false

# Example 8
@ints = (2, 1, 2, 0);
print( digit_count_value(@ints), "\n"); # Output: false

# Example 9
@ints = (3, 1, 2, 0);
print( digit_count_value(@ints), "\n"); # Output: false
