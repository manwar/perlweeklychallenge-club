#!/usr/bin/perl
use strict;
use warnings;
use Math::Matrix;

sub row_max_ones {

    my ($x) = @_;
    # a boolean matrix is a matrix whose entries are either 0 or 1
    if ( $x -> is_bool() ) {

        # find() returns the location of each non-zero element in terms of $i and $j.
        # e.g. (0, 0), (0, 2), (1, 0) and (2, 0) are the coordinates of value 1 in Example 4 below
        my($i, $j) = $x -> find();

        # count occurrences of each element and save into %count
        my %count;

        foreach my $elem (@$i) {
            $count{$elem}++;
        }

        # alternatively: map { $count{$_}++ } @$i;

        # iterate through the hash to find the maximum value
        my ($max_value, $max_row) = (0, 0);

        foreach my $row (sort keys(%count)) {

            if ($count{$row} > $max_value) {
                $max_value = $count{$row};
                # assign $row to $max_row only if both $max_value and $row have become new values
                $max_row = $row if ($max_value != 0 && $row != $max_row);
            }
        }

        print("Row maximum ones: ", ($max_row + 1), "\n");

    }
    else {
        print("Error: no valid matrix!\n");
    }
}

# TESTS
my $matrix;

# Example 1
$matrix = [ [0, 1],
            [1, 0],
          ];
row_max_ones(Math::Matrix -> new($matrix)); # Output: 1

# Example 2
$matrix = [ [0, 0, 0],
            [1, 0, 1],
          ];
row_max_ones(Math::Matrix -> new($matrix)); # Output: 2

# Example 3
$matrix = [ [0, 0],
            [1, 1],
            [0, 0],
          ];
row_max_ones(Math::Matrix -> new($matrix)); # Output: 2

# own test cases
my $x;

# Example 4
$x = Math::Matrix -> new([1, 0, 1],
                         [1, 0, 0],
                         [1, 0, 0]);

row_max_ones($x); # Output: 1

# Example 5
$x = Math::Matrix -> new([1, 0, 0],
                         [1, 0, 0],
                         [1, 0, 1]);

row_max_ones($x); # Output: 3

# Example 6
$x = Math::Matrix -> new([1, 0, 0],
                         [1, 0, 1],
                         [1, 0, 1]);

row_max_ones($x); # Output: 2
