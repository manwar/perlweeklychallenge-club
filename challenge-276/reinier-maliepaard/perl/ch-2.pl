#!/usr/bin/perl
use strict;
use warnings;

use Statistics::Frequency;

sub max_freq {

    my ($count, $f, %freq) = (0);

    $f = Statistics::Frequency->new( @_ );
    %freq = $f->frequencies;

    $count += $f->frequencies_max for ( grep { $_ == $f->frequencies_max } values %freq );

    return ($count);
}

# Tests

my (@ints);

# Example 1
@ints = (1, 2, 2, 4, 1, 5);
print(max_freq((@ints)), "\n"); # Output: 4

# Example 2
@ints = (1, 2, 3, 4, 5);
print(max_freq((@ints)), "\n"); # Output: 5

# Example 3
@ints = (1, 1, 3, 3, 3, 3);
print(max_freq((@ints)), "\n"); # Output: 4

# Example 4
@ints = (1, 2, 2, 4);
print(max_freq((@ints)), "\n"); # Output: 2
