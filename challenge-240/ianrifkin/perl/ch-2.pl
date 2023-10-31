#!/usr/bin/perl
use warnings;
use strict;

# You are given an array of integers.
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.


# Example 1
my @ints = (0, 2, 1, 5, 3, 4);
create_new_array(@ints);

# Example 2
@ints = (5, 0, 1, 2, 3, 4);
create_new_array(@ints);

sub create_new_array {
    my (@ints) = @_;
    my @new_ints;
    # Loop through old array to create new array
    for (my $i = 0; $i < @ints; $i++) {
	$new_ints[$i] = $ints[$ints[$i]];
    }
    # Note on above: This should naturally meet the requirement to
    #                "where 0 <= i < new.length" unless I am confused
    
    # print new array matching desired formatting
    print "(" . join(', ', @new_ints) . ")\n";
}

