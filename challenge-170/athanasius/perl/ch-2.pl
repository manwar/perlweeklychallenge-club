#!perl

###############################################################################
=comment

Perl Weekly Challenge 170
=========================

TASK #2
-------
*Kronecker Product*

Submitted by: Mohammad S Anwar

You are given 2 matrices.

Write a script to implement Kronecker Product on the given 2 matrices.

For more information, please refer
[ https://en.wikipedia.org/wiki/Kronecker_product |wikipedia page].


For example,

 A = [ 1 2 ]
     [ 3 4 ]

 B = [ 5 6 ]
     [ 7 8 ]

 A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
         [     [ 7 8 ]       [ 7 8 ] ]
         [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
         [     [ 7 8 ]       [ 7 8 ] ]

       = [ 1x5 1x6 2x5 2x6 ]
         [ 1x7 1x8 2x7 2x8 ]
         [ 3x5 3x6 4x5 4x6 ]
         [ 3x7 3x8 4x7 4x8 ]

       = [  5  6 10 12 ]
         [  7  8 14 16 ]
         [ 15 18 20 24 ]
         [ 21 24 28 32 ]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Each of the two input matrices is entered on the command line as a string, with
rows separated by vertical bars ("|"), and, within each row, real-number
elements separated by commas. For example:

    perl ch-1.pl "1,2|3,4" "5,6|7,8"

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <A> <B>

    <A>    Matrix A (string: columns separated by ',' and rows by '|')
    <B>    Matrix B (string: columns separated by ',' and rows by '|')\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 170, Task #2: Kronecker Product (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($matrixA, $matrixB) = parse_command_line();

    print sprint_matrix( 'A', $matrixA ), "\n",
          sprint_matrix( 'B', $matrixB ), "\n";

    my ($rowsA, $colsA) = (scalar @$matrixA, scalar @{ $matrixA->[ 0 ] });
    my ($rowsB, $colsB) = (scalar @$matrixB, scalar @{ $matrixB->[ 0 ] });
    my  @matrixK;

    # Calculate the Kronecker product

    for my $rowA (0 .. $rowsA - 1)
    {
        for my $colA (0 .. $colsA - 1)
        {
            for my $rowB (0 .. $rowsB - 1)
            {
                my $rowK = ($rowA * $rowsB) + $rowB;

                for my $colB (0 .. $colsB - 1)
                {
                    my $colK = ($colA * $colsB) + $colB;

                    $matrixK[ $rowK ][ $colK ] = $matrixA->[ $rowA ][ $colA ] *
                                                 $matrixB->[ $rowB ][ $colB ];
                }
            }
        }
    }

    print sprint_matrix( 'A x B', \@matrixK );
}

#------------------------------------------------------------------------------
sub sprint_matrix
#------------------------------------------------------------------------------
{
    my ($name, $matrix) = @_;
    my  $str_matrix     = format_elements( $matrix );

    my  $out =  sprintf "%s = [ %s ]\n",
                         $name,   join ' ', @{ $str_matrix->[ 0  ] };

    my  $prefix = ' ' x (length( $name ) + 3);

    for my $i (1 .. $#$matrix)
    {
        $out .= sprintf "%s[ %s ]\n",
                         $prefix, join ' ', @{ $str_matrix->[ $i ] };
    }

    return $out;
}

#------------------------------------------------------------------------------
sub format_elements
#------------------------------------------------------------------------------
{
    my ($matrix)    = @_;
    my  @max_widths = get_widths( $matrix );       # Find maximum column widths

    # Convert each element to a string and left-justify with spaces as required

    my $col_end = scalar @{ $matrix->[ 0 ] } - 1;
    my @new_matrix;

    for my $row (0 .. $#$matrix)
    {
        for my $col (0 .. $col_end)
        {
            my $element = $matrix->[ $row ][ $col ];

            $new_matrix[ $row ][ $col ] =
                sprintf "% *s", $max_widths[ $col ], $element;
        }
    }

    return \@new_matrix;
}

#------------------------------------------------------------------------------
sub get_widths
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $col_end = scalar @{ $matrix->[ 0 ] } - 1;
    my  @max_widths;

    for my $col (0 .. $col_end)
    {
        my $max_width;

        for my $row (0 .. $#$matrix)
        {
            my $width  = length $matrix->[ $row ][ $col ];
            $max_width = $width if !defined $max_width || $width > $max_width;
        }

        push @max_widths, $max_width;
    }

    return @max_widths;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2
            or die "Expected 2 command line arguments, found $args\n$USAGE";

    my @matrices;

    for my $i (0, 1)
    {
        my @row_strs = split /\|/, $ARGV[ $i ];
        my @rows;

        for my $j (0 .. $#row_strs)
        {
            my $row_str = $row_strs[ $j ];
            my @cols = map { / ^ \s* (\S+) \s* $ /x } split /,/, $row_str;

            $j > 0 && scalar @cols != scalar @{ $rows[ 0 ] }
                    and error( 'Inconsistent number of columns in row' );

            for my $element (@cols)
            {
                $element =~ / ^ $RE{num}{real} $ /x
                    or  error( qq["$element" is not a valid real number] );
            }

            push @rows, \@cols;
        }

        $matrices[ $i ] = \@rows;
    }

    return @matrices;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
