#!/usr/bin/perl
use strict;
use warnings;

=begin
Light fields are created by combining the column letters b, d, f, h and
the odd row numbers 1, 3, 5, 7, or the column letters a, c, e, g and
the even row numbers 2, 4, 6, 8. When representing the letters by their
numeric ASCII codes and adding these to the row numbers, the result is
always an odd number. Example: b1 -> 98 + 1 = 99 -> odd -> light field
=cut

# Solution

sub get_field_color {

    # Split the field notation into column and row
    my ($col, $row) = ($_[0] =~ /([a-h])([1-8])/);

    # Ensure the input is valid
    return("invalid field\n") unless (defined $col) && (defined $row);

    # Convert column letter to the numeric ASCII value
    # and add this number to the row number
    ( ( ord($col) + $row ) % 2 != 0 ) ? return("true\n") # light
                                      : return("false\n"); # dark
}

# Tests

my $field;

# Example 1
$field = "d3";
print(get_field_color($field)); # Output: true

# Example 2
$field = "g5";
print(get_field_color($field)); # Output: false

# Example 3
$field = "e6";
print(get_field_color($field)); # Output: true

# Example 4
$field = "z8";
print(get_field_color($field)); # Output: invalid field

