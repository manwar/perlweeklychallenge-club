#!perl

###############################################################################
=comment

Perl Weekly Challenge 084
=========================

Task #2
-------
*Find Square*

Submitted by: Mohammad S Anwar

You are given matrix of size m x n with only 1 and 0.

Write a script to find the count of squares having all four corners set as 1.

Example 1:

 Input: [ 0 1 0 1 ]
        [ 0 0 1 0 ]
        [ 1 1 0 1 ]
        [ 1 0 0 1 ]

 Output: 1

Explanation:

There is one square (3x3) in the given matrix with four corners as 1 starts at
r=1;c=2.

 [ 1 0 1 ]
 [ 0 1 0 ]
 [ 1 0 1 ]

Example 2:

 Input: [ 1 1 0 1 ]
        [ 1 1 0 0 ]
        [ 0 1 1 1 ]
        [ 1 0 1 1 ]

 Output: 4

Explanation:

There is one square (4x4) in the given matrix with four corners as 1 starts at
r=1;c=1.

There is one square (3x3) in the given matrix with four corners as 1 starts at
r=1;c=2.

There are two squares (2x2) in the given matrix with four corners as 1. First
starts at r=1;c=1 and second starts at r=3;c=3.

Example 3:

 Input: [ 0 1 0 1 ]
        [ 1 0 1 0 ]
        [ 0 1 0 0 ]
        [ 1 0 0 1 ]

 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $EXPLAIN => 1;
const my $USAGE   =>
qq[Usage:
  perl $0 [<rows> ...]

    [<rows> ...]    1+ same-width rows, each a string of 1+ "1" and "0" chars
];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 084, Task #2: Find Square (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @A = get_matrix();

    print_matrix(\@A);

    my $width    = scalar @{ $A[0] };
    my $height   = scalar @A;
    my $max_side = $width <= $height ? $width : $height;
    my $count    = 0;
    my @squares;

    for my $row_top (0 .. $height - 2)
    {
        for my $col_left (0 .. $width - 2)
        {
            next unless $A[$row_top][$col_left] eq '1';

            for my $side (1 .. $max_side)
            {
                my $col_right = $col_left + $side;

                next unless $col_right < $width &&
                            $A[$row_top][$col_right] eq '1';

                my $row_bottom = $row_top + $side;

                next unless $row_bottom < $height              &&
                            $A[$row_bottom][$col_left ] eq '1' &&
                            $A[$row_bottom][$col_right] eq '1';

                ++$count;

                push @squares, [ $row_top + 1, $col_left + 1, $side + 1 ]
                    if $EXPLAIN;
            }
        }
    }

    print " Output: $count\n";

    if ($EXPLAIN && scalar @squares > 0)
    {
        print "\nExplanation:\n\n";

        for (@squares)
        {
            printf " %dx%d square with top left corner at row %d, column %d\n",
                    (@$_)[2, 2, 0, 1];
        }
    }
}

#------------------------------------------------------------------------------
sub get_matrix
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0           or  error('No command-line arguments');

    my $width = length $ARGV[0];

    $width > 0                 or  error('Empty first row');

    my @A;

    for my $i (0 .. $#ARGV)
    {
        $ARGV[$i] =~ /([^10])/ and error("Invalid character \"$1\"");

        length $ARGV[$i] == $width
                               or  error(sprintf 'Inconsistent number of ' .
                                                 'columns in row %d', $i + 1);

        push @A, [ split //, $ARGV[$i] ];
    }

    return @A;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub print_matrix
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    printf " Input: [ %s ]\n", join ' ', @{ $matrix->[0 ] };
    printf "        [ %s ]\n", join ' ', @{ $matrix->[$_] } for 1 .. $#$matrix;
    print  "\n";
}

###############################################################################
