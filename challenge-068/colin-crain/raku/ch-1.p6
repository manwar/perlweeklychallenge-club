#!/usr/bin/env perl6
#
#
#       zip-zilch-zero.raku
#
#         TASK #1 › Zero Matrix
#         Submitted by: Mohammad S Anwar
#         You are given a matrix of size M x N having only 0s and 1s.
#
#         Write a script to set the entire row and column to 0 if an
#         element is 0.
#
#         Example 1
#             Input:  [1, 0, 1]
#                     [1, 1, 1]
#                     [1, 1, 1]
#
#             Output: [0, 0, 0]
#                     [1, 0, 1]
#                     [1, 0, 1]
#         Example 2
#             Input:  [1, 0, 1]
#                     [1, 1, 1]
#                     [1, 0, 1]
#
#             Output: [0, 0, 0]
#                     [1, 0, 1]
#                     [0, 0, 0]
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

multi MAIN ( ) {
    say q:to/END/;
    Usage: ./zip-zilch-zero.raku row1 row2 row3
        rows are values 1 and 0 concactenated into strings
        ex: ./zip-zilch-zero.raku 1001 1111 1011 1111
    END
}

multi MAIN ( *@matrix ) {
    ## as by challenge definition we only use 1s and 0s,
    ## concatenate individual rows into strings
    ## example: 101 111 111 001
    @matrix .= map({.comb.Array});       ## comb makes Seq not a list
    my $rows = @matrix.elems;
    my $cols = @matrix[0].elems;
    print_matrix(@matrix,  "Input:");

    ## 0s are considered 'opaque' -- a single 0 occludes the entire
    ## row or column We pass once through the matrix, row by row,
    ## recording the 0 occurence data to two arrays, one for rows, the
    ## other columns
    my @row_zeros;
    my @col_zeros;

    for ^$rows -> $row {
        @row_zeros[$row] ?|= (@matrix[$row].sum != $cols);
        for ^$cols -> $col {
            @col_zeros[$col] ?|= ! @matrix[$row][$col].Int;
        }
    }

    ## report midway through
    say "Zero Occlusions:";
    say "   cols: ",  @col_zeros;
    say "   rows: ",  @row_zeros, "\n";

    ## now we can pass through the matrix again, transferring the
    ## occurence data back to the rows and columns, zeroing them out
    ## as specified
    for ^$rows -> $row {
        next if @row_zeros[$row] and @matrix[$row] = (0) xx $cols;
        for ^$cols -> $col {
            @matrix[$row][$col] = (! @col_zeros[$col]).Int;
        }
    }

    print_matrix(@matrix,  "Output:");

}

sub print_matrix ( @matrix, $heading? ) {
    $heading.say if $heading;
    ("\t" ~ $_.join(' ')).say for @matrix;
    "".say;
}
