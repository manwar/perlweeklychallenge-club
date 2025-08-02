#!perl

################################################################################
=comment

Perl Weekly Challenge 257
=========================

TASK #2
-------
*Reduced Row Echelon*

Submitted by: Ali Moradi

Given a matrix M, check whether the matrix is in reduced row echelon form.

A matrix must have the following properties to be in reduced row echelon form:

  1. If a row does not consist entirely of zeros, then the first
     nonzero number in the row is a 1. We call this the leading 1.
  2. If there are any rows that consist entirely of zeros, then
     they are grouped together at the bottom of the matrix.
  3. In any two successive rows that do not consist entirely of zeros,
     the leading 1 in the lower row occurs farther to the right than
     the leading 1 in the higher row.
  4. Each column that contains a leading 1 has zeros everywhere else
     in that column.

For example:

  [
     [1,0,0,1],
     [0,1,0,2],
     [0,0,1,3]
  ]

The above matrix is in reduced row echelon form since the first nonzero number
in each row is a 1, leading 1s in each successive row are farther to the right,
and above and below each leading 1 there are only zeros.

For more information check out this wikipedia 
[https://en.wikipedia.org/wiki/Row_echelon_form|article].

Example 1

    Input: $M = [
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 2

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ]
    Output: 1

Example 3

    Input: $M = [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 1

Example 4

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
                ]
    Output: 0

Example 5

    Input: $M = [
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 6

    Input: $M = [
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input matrix M is entered on the command-line as a non-empty list of
   strings (the matrix rows) containing elements separated by whitespace. For
   example, the matrix:

        [ 1 1 0 ]
        [ 0 1 0 ]
        [ 0 0 0 ]

    is entered as: >raku ch-2.raku "1 1 0" "0 1 0" "0 0 1"

Assumptions
-----------
1. The input matrix M is an integer matrix.
2. M is not an empty matrix.

Note
----
Matrix-handling code is adapted from the solution to Task 2 for Week 248.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;
use enum           qw( AllZeros LeadingOne Other );

const my $USAGE => <<END;
Usage:
  perl $0 [<M> ...]
  perl $0

    [<M> ...]    A non-empty integer matrix
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 257, Task #2: Reduced Row Echelon (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $matrix = parse_matrix( \@ARGV );

        print_matrix( 'Input:  $M = ', $matrix );

        printf "Output: %d\n", is_reduced_row_echelon( $matrix );
    }
}

#-------------------------------------------------------------------------------
sub is_reduced_row_echelon
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    # Test matrix properties 1 and 2:
    # 1. If a row does not consist entirely of zeros, then the first nonzero
    #    number in the row is a 1. We call this the leading 1.
    # 2. If there are any rows that consist entirely of zeros, then they are
    #    grouped together at the bottom of the matrix.

    my $row_types = classify_rows( $matrix );
    my $all_zeros = 0;

    for my $type (@$row_types)
    {
        if    ($type == AllZeros)
        {
            $all_zeros = 1;
        }
        elsif ($type == LeadingOne)
        {
            return 0 if $all_zeros;                              # Requirement 2
        }
        else
        {
            return 0;                                            # Requirement 1
        }
    }

    # Test matrix properties 3 and 4:
    # 3. In any two successive rows that do not consist entirely of zeros, the
    #    leading 1 in the lower row occurs farther to the right than the leading
    #    1 in the higher row.
    # 4. Each column that contains a leading 1 has zeros everywhere else in that
    #    column.

    return check_leading_ones( $matrix, $row_types );
}

#-------------------------------------------------------------------------------
sub classify_rows
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $width   = scalar @{ $matrix->[ 0 ] };
    my  @row_types;

    L_OUTER:
    for my $r (0 .. $#$matrix)
    {
        my $row = $matrix->[ $r ];

        for my $c (0 .. $width - 1)
        {
            my $element = $row->[ $c ];

            if    ($element == 1)
            {
                push @row_types, LeadingOne;
                next L_OUTER;
            }
            elsif ($element != 0)
            {
                push @row_types, Other;
                next L_OUTER;
            }
        }

        push @row_types, AllZeros;
    }

    return \@row_types;
}

#-------------------------------------------------------------------------------
sub check_leading_ones
#-------------------------------------------------------------------------------
{
    my ($matrix, $row_t) = @_;
    my  $width    = scalar @{ $matrix->[ 0 ] };
    my  $last_one = -1;

    for my $r (0 .. $#$matrix)
    {
        last if $row_t->[ $r ] == AllZeros;

        my $row = $matrix->[ $r ];

        for my $c (0 .. $width - 1)
        {
            my $element = $row->[ $c ];

            if ($element == 1)
            {
                return 0 unless $c > $last_one;             # Test Requirement 3

                $last_one = $c;

                for my $rr (0 .. $#$matrix)                 # Test Requirement 4
                {
                    return 0 unless $rr == $r || $matrix->[ $rr ][ $c ] == 0;
                }

                last;
            }
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my ($M) = @_;
    my (@matrix, $num_cols);

    for my $row_str (@$M)
    {
        my @row;

        for my $elem (grep { / \S /x } split / \s+ /x, $row_str)
        {
            if ($elem =~ / ^ $RE{num}{int} $ /x)
            {
                push @row, $elem;
            }
            else
            {
                error( qq[Element "$elem" is not a valid integer] );
            }
        }

        push @matrix, \@row;

        if (defined $num_cols)
        {
            scalar @row == $num_cols
                or error( 'The input matrix is not rectangular' );
        }
        else
        {
            $num_cols = scalar @row;
            $num_cols > 0 or error( 'Empty row' );
        }
    }

    return \@matrix;
}

#-------------------------------------------------------------------------------
sub print_matrix
#-------------------------------------------------------------------------------
{
    my ($prefix, $matrix) = @_;
    my  $tab   = ' ' x length $prefix;
    my  @width = (1) x scalar @{ $matrix->[ 0 ] };

    for my $row (@$matrix)
    {
        for my $i (0 .. $#$row)
        {
            my $w = length $row->[ $i ];

            $width[ $i ] = $w if $w > $width[ $i ];
        }
    }

    print "$prefix\[\n";

    for my $row (@$matrix)
    {
        my @row_str;

        for my $i (0 .. $#$row)
        {
            push @row_str, sprintf '%*d', $width[ $i ], $row->[ $i ];
        }

        printf "%s  [%s]\n", $tab, join ', ', @row_str;
    }

    print "$tab]\n";
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $matrix_str, $expected) = split / \| /x, $line;

        for ($test_name, $matrix_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @M      = split / \; /x, $matrix_str;
        my $matrix = parse_matrix( \@M );
        my $is_rre = is_reduced_row_echelon( $matrix );

        is $is_rre, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 0|1 0  0 1  ;   0 1 0 2   ;   0 0 1  3               |1
Example 1|1 1  0    ;   0 1 0     ;   0 0 0                  |0
Example 2|0 1 -2 0 1;   0 0 0 1  3;   0 0 0  0 0;   0 0 0 0 0|1
Example 3|1 0  0 4  ;   0 1 0 7   ;   0 0 1 -1               |1
Example 4|0 1 -2 0 1;   0 0 0 0  0;   0 0 0  1 3;   0 0 0 0 0|0
Example 5|0 1  0    ;   1 0 0     ;   0 0 0                  |0
Example 6|4 0  0 0  ;   0 1 0 7   ;   0 0 1 -1               |0
