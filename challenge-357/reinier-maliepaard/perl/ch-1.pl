#!/usr/bin/perl
use strict;
use warnings;

# Some didactical hints:

# Function find_max_alphanum($array_ref)
# Finds the maximum value in an array of alphanumeric strings.
# - Numeric strings (including scientific notation) are treated as numbers.
# - Non-numeric strings are treated by their length.
# - Returns the maximum value found, or undef if the array is empty.

# NOTE:
# This function expects an ARRAY REFERENCE as input. Why?
# - Avoids flattening of arrays when passed to functions.
# - More memory-efficient for large arrays.
# - Preserves the structure of complex data.

# NOTE:
# "7.89e4" is according to the challenge description "not numeric" and should be treated as length("7.89e4") == 6
# My solution extends the definition of "numeric string" beyond "digits only".

sub find_max_alphanum {
    my ($array_ref) = @_;

    die "Error: Expected an array reference" unless ref($array_ref) eq 'ARRAY';

    # Handle empty arrays
    return undef unless @$array_ref;

    my $max;

    foreach my $item (@$array_ref) {
        # Handle undefined values
        next unless defined $item;

        my $val;
        # Regex matches integers, decimals, and scientific notation
        if ($item =~ /^[+-]?(?:\d+(?:\.\d+)?|\.\d+)(?:[eE][+-]?\d+)?$/) {
            # + 0 ensures strings like "7.89e4" are treated as numbers
            $val = $item + 0;
        } else {
            $val = length($item);
        }

        $max = $val if !defined $max || $val > $max;
    }

    return $max;
}



# Tests

# my @strings = ("123", "45", "6"); # 123
# my @strings = ("abc", "de", "fghi"); # 4
# my @strings = ("0012", "99", "a1b2c"); # 99
# my @strings = ("x", "10", "xyz", "007"); # 10

my @strings = ("hello123", "2026", "perl", "7.89e4"); # 78900

print "The max value is: " . find_max_alphanum(\@strings) . "\n";
