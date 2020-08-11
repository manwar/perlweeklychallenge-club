#!perl

################################################################################
=comment

Perl Weekly Challenge 064
=========================

Task #1
-------
*Minimum Sum Path*

*Submitted by:* Mohammad S Anwar
*Reviewed by:* Ryan Thompson

Given an _m × n_ matrix with non-negative integers, write a script to find a
path from top left to bottom right which minimizes the sum of all numbers along
its path. You can only move either down or right at any point in time.

*Example*

Input:

  [ 1 2 3 ]
  [ 4 5 6 ]
  [ 7 8 9 ]

The minimum sum path looks like this:

  1→2→3
      ↓
      6
      ↓
      9

Thus, your script could output: 21 ( 1 → 2 → 3 → 6 → 9 )

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use List::Util qw( max );
use constant DEBUG => 0;

const my $USAGE => "Usage:\n  perl $0 [<file>]\n\n" .
                   "    <file>    string: [path/]name of matrix data file\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 064, Task #1: Minimum Sum Path (Perl)\n\n";

    my $matrix;
    my $args = scalar @ARGV;

    if    ($args == 0)          # Default: Example matrix
    {
        $matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ];
    }
    elsif ($args == 1)          # Read matrix data from file
    {
        $matrix = load_matrix($ARGV[0]);
    }
    else
    {
        die $USAGE;
    }

    my $rows = scalar(@$matrix)           - 1;
    my $cols = scalar( $matrix->[0]->@* ) - 1;
    my $sums = find_min_sums($matrix,        $rows, $cols);
    my $path = find_min_path($matrix, $sums, $rows, $cols);

    if (DEBUG)
    {
        print_matrix('Original matrix', $matrix, $rows, $cols);
        print_matrix('Minimum sums',    $sums,   $rows, $cols);
    }

    print $sums->[0][0], " ( ", join(' -> ', @$path), " )\n";
}

#-------------------------------------------------------------------------------
sub find_min_sums
#-------------------------------------------------------------------------------
{
    my ($matrix, $rows, $cols) = @_;
    my  $sums;

    # Calculate the minimal right-or-down path sum for each matrix element,
    # beginning at the bottom right corner and moving left and up. For a given
    # element at row r, column c, the minimal path sum is the matrix value for
    # (r,c) plus the smaller of the sums for (r+1,c) and (r,c+1).

    # Bottom right corner

    $sums->[$rows][$cols] = $matrix->[$rows][$cols];

    # Bottom row

    for my $col (reverse 0 .. $cols - 1)
    {
        $sums->[$rows][$col] = $matrix->[$rows][$col    ] +
                               $sums->  [$rows][$col + 1];
    }

    # Right column

    for my $row (reverse 0 .. $rows - 1)
    {
        $sums->[$row][$cols] = $matrix->[$row    ][$cols] +
                               $sums->  [$row + 1][$cols];
    }

    # Remaining rows, bottom to top

    for my $row (reverse 0 .. $rows - 1)
    {
        # Remaining columns in this row, right to left

        for my $col (reverse 0 .. $cols - 1)
        {
            my $right = $sums->[$row    ][$col + 1];
            my $down  = $sums->[$row + 1][$col    ];

            # Choose the smaller of the two path sums: right or down

            $sums->[$row][$col] = $matrix->[$row][$col] +
                                (($right <= $down) ? $right : $down);
        }
    }

    return $sums;
}

#-------------------------------------------------------------------------------
sub find_min_path
#-------------------------------------------------------------------------------
{
    my ($matrix, $sums, $rows, $cols) = @_;
    my  @path = $matrix->[0][0];
    my  $row  = 0;
    my  $col  = 0;

    until ($row == $rows && $col == $cols)
    {
        if    ($row == $rows)
        {
            push @path, $matrix->[$row][++$col];
        }
        elsif ($col == $cols)
        {
            push @path, $matrix->[++$row][$col];
        }
        else
        {
            my $right = $sums->[$row][$col + 1];
            my $down  = $sums->[$row + 1][$col];

            if ($right <= $down)
            {
                push @path, $matrix->[$row][++$col];
            }
            else
            {
                push @path, $matrix->[++$row][$col];
            }
        }
    }

    return \@path;
}

#-------------------------------------------------------------------------------
sub load_matrix
#-------------------------------------------------------------------------------
{
    my ($file) = @_;
    my  $matrix;

    open(my $in, '<', $file)
        or die "Cannot open file '$file' for reading, stopped";

    while (<$in>)
    {
        chomp;
        my @row = split /,/;
        push @$matrix, \@row;
    }

    close $in
        or die "Cannot close file '$file', stopped";

    return $matrix;
}

#-------------------------------------------------------------------------------
sub print_matrix
#-------------------------------------------------------------------------------
{
    my ($title, $matrix, $rows, $cols) = @_;

    print "$title:\n";

    my   @entries;
    push @entries, $matrix->[$_]->@* for 0 .. $rows;

    my   $max = max map { length $_ } @entries;

    for my $row (0 .. $rows)
    {
        printf "[ %s ]\n",
                join ' ', map { sprintf '%*d', $max, $_ } $matrix->[$row]->@*;
    }

    print "\n";
}

################################################################################
