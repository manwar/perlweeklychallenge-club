#!/usr/bin/perl
use strict;
use warnings;
use Statistics::Frequency;

=begin
Dive back again into the Statistics::Frequency module - because we clearly can't get enough of it
=cut

sub lucky_integer {
    my @ints = @_;

    # return -1 if the input array is empty
    return(-1) unless @ints;

    # create a new Statistics::Frequency object
    my $freq = Statistics::Frequency->new(@ints);

    # filter the list to only include elements where the
    # frequency equals the element's value
    my @list = grep { $_ == $freq->frequency($_) } @ints;

    # sort the filtered list in descending order
    @list = sort { $b <=> $a } @list;

    # return the first element (largest) or -1 if the list is empty
    return(@list ? $list[0] : -1);
}

# Tests

my @ints;

# Example 1
@ints = (2, 2, 3, 4);
print(lucky_integer(@ints), "\n"); # Output: 2

# Example 2
@ints = (1, 2, 2, 3, 3, 3);
print(lucky_integer(@ints), "\n"); # Output: 3

# Example 3
@ints = (1, 1, 1, 3);
print(lucky_integer(@ints), "\n"); # Output: -1
