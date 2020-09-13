#!perl

###############################################################################
=comment

Perl Weekly Challenge 077
=========================

Task #2
-------
*Lonely X*

Submitted by: Mohammad S Anwar

You are given m x n character matrix consists of O and X only.

Write a script to count the total number of X surrounded by O only. Print 0 if
none found.

Example 1:

 Input: [ O O X ]
        [ X O O ]
        [ X O O ]

 Output: 1 as there is only one X at the first row last column surrounded by
 only O.

Example 2:

 Input: [ O O X O ]
        [ X O O O ]
        [ X O O X ]
        [ O X O O ]

 Output: 2

     a) First  X found at Row 1 Col 3.

     b) Second X found at Row 3 Col 4.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $USAGE =>
"Usage:
  perl $0 [<rows> ...]

    [<rows> ...]    1+ same-width rows, each a string of 'O' and 'X' chars\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 077, Task #2: Lonely X (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $matrix = get_matrix(@ARGV);

    print_matrix($matrix);

    my $lonelyX = find_lonely_X($matrix);
    my $count   = scalar @$lonelyX;

    print " Output: $count\n", $count ? "\n" : '';

    my $i = 0;
    printf "   %d. Lonely X found at Row %d Col %d\n", ++$i, @$_ for @$lonelyX;
}

#------------------------------------------------------------------------------
sub find_lonely_X
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    my @lonely_X;
    my $max_row = $#$matrix;
    my $max_col = $#{ $matrix->[0] };

    for my $row (0 .. $max_row)
    {
        COLUMN: for my $col (0 .. $max_col)
        {
            if ($matrix->[$row][$col] eq 'X')
            {
                for my $row_delta (-1, 0, 1)
                {
                    my      $neighbr_row = $row + $row_delta;
                    next if $neighbr_row < 0 ||
                            $neighbr_row > $max_row;

                    for my $col_delta (-1, 0, 1)
                    {
                        next if $row_delta == 0 &&
                                $col_delta == 0;         # Self, not neighbour!

                        my      $neighbr_col = $col + $col_delta;
                        next if $neighbr_col < 0 ||
                                $neighbr_col > $max_col;

                        next COLUMN                      # This X is not lonely
                             if $matrix->[$neighbr_row][$neighbr_col] eq 'X';
                    }
                }

                push @lonely_X, [$row + 1, $col + 1];    # A lonely X
            }
        }
    }

    return \@lonely_X;
}

#------------------------------------------------------------------------------
sub get_matrix
#------------------------------------------------------------------------------
{
    my @rows = @_;

    scalar @rows > 0 or die $USAGE;

    my $width = length $rows[0];
    my @matrix;

    for my $i (0 .. $#rows)
    {
        my $row = $rows[$i];

        $row =~ / ( [^OX] ) /x
            and die "Invalid character '$1' in the input matrix\n$USAGE";

        length $row == $width
            or  die 'Inconsistent number of columns in row ' . ($i + 1) .
                    "\n$USAGE";

        $matrix[$i] = [ split '', $row ];
    }

    return \@matrix;
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
