#!/usr/bin/perl
use strict;
use warnings;
use Math::Matrix;

# the function 'sum_rows_and_columns' is invoked in the function 'find_special_positions' below
sub sum_rows_and_columns {

    # A special positions matrix highlights positions that meet
    # the specific criterium, having a unique '1' in its row and column.
    # So, it simply means adding the values of the relevant rows and columns and evaluating them

    my ($r, $c, $x) = @_;
    my $count_special_positions = 0;

    # nrow(), ncol(), getrow() and getcol() are self-explanatory methods of the module Math::Matrix

    my $sum_rows = 0;
    for my $ii (0 .. $x -> ncol() - 1) {
        $sum_rows += ($x -> getrow($r))->[0]->[$ii];
    }

    my $sum_cols = 0;
    for my $ii (0 .. $x -> nrow() - 1) {
        $sum_cols += ($x -> getcol($c))->[$ii]->[0];
    }

    # evaluate the calculated sum of row and column
    if ( ($sum_rows == 1) && ($sum_cols == 1) ) {
        $count_special_positions++;
    }

    return $count_special_positions;
}

sub find_special_positions {

    my ($x) = @_;
    # a boolean matrix is a matrix whose entries are either 0 or 1
    if ( $x -> is_bool() ) {

        # find() returns the location of each non-zero element in terms of $i and $j.
        # e.g. (0, 0), (1, 2) and (2, 0) are the coordinates of value 1 in Example 1 below
        # they can be created by processing @$i and @$j: see arguments function
        my($i, $j) = $x -> find();

        my $sum_total = 0;

        for my $z (0 .. scalar(@$i) - 1) {
            # invoke the function 'sum_rows_and_columns' for each '1'
            $sum_total += sum_rows_and_columns($i->[$z], $j->[$z], $x);
        }

        print("Number of special positions: ", $sum_total, "\n");
    }
    else {
        print("Error: no valid matrix!\n");
    }
}

# TESTS

my $x;

# Example 1: 3 x 3 matrix
$x = Math::Matrix -> new([1, 0, 0],
                         [0, 0, 1],
                         [1, 0, 0]);

find_special_positions($x); # Output: 1

# Example 2: 3 x 3 matrix
$x = Math::Matrix -> new([1, 0, 0],
                         [0, 1, 0],
                         [0, 0, 1]);

find_special_positions($x); # Output: 3

# Example 3: 3 x 3 matrix
$x = Math::Matrix -> new([1, 0, 0],
                         [0, 0, 1],
                         [1, 0, 1]);

find_special_positions($x); # Output: 0

# Example 4: permutation matrix, 3 x 3 matrix
$x = Math::Matrix -> new([0, 1, 0],
                         [1, 0, 0],
                         [0, 0, 1]);

find_special_positions($x); # Output: 3

# Example 5: 3 x 4 matrix
$x = Math::Matrix -> new([0, 1, 0, 0],
                         [0, 0, 0, 1],
                         [0, 0, 1, 0]);

find_special_positions($x); # Output: 3

# Example 6: 4 x 3 matrix
$x = Math::Matrix -> new([0, 1, 0],
                         [0, 0, 0],
                         [0, 0, 1],
                         [0, 0, 1]);

find_special_positions($x); # Output: 1
