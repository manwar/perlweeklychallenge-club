#!/usr/bin/perl
use strict;
use warnings;
use Statistics::Frequency;

=begin
Let's use the marvellous Statistics CPAN module!
=cut

sub unique_number {
    my @ints = @_;
    # create a new Statistics::Frequency object
    my $freq  = Statistics::Frequency->new(@ints);

    for (my $i = 0; $i <= $#ints; $i++) {
        $freq->frequency($element) returns the frequency of an element
        return($ints[$i]) if ( $freq->frequency($ints[$i]) == 1);
    }

}

# Tests

my @ints;

# Example 1
@ints = (3, 3, 1);
print(unique_number(@ints), "\n"); # Output: 1

# Example 2
@ints = (3, 2, 4, 2, 4);
print(unique_number(@ints), "\n"); # Output: 3

# Example 3
@ints = (1);
print(unique_number(@ints), "\n"); # Output: 1

# Example 4
@ints = (4, 3, 1, 1, 1, 4);
print( unique_number(@ints), "\n" ); # Output: 3

# Example 5
@ints = (3, 3, 3, 2, 2, 1);
print( unique_number(@ints), "\n" ); # Output: 1
