#!perl

###############################################################################
=comment

Perl Weekly Challenge 100
=========================

Task #2
-------
*Triangle Sum*

Submitted by: Mohammad S Anwar

You are given triangle array.

Write a script to find the minimum path sum from top to bottom.

When you are on index i on the current row then you may move to either index i
or index i + 1 on the next row.

Example 1:

 Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
 Output: 8

 Explanation: The given triangle

             1
            2 4
           6 4 9
          5 1 7 2

 The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8

              [1]
            [2]  4
            6 [4] 9
           5 [1] 7 2

Example 2:

 Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
 Output: 7

 Explanation: The given triangle

             3
            3 1
           5 2 3
          4 3 1 3

 The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

              [3]
             3  [1]
            5 [2] 3
           4 3 [1] 3

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm

Although the path sum is from top to bottom, the algorithm for finding the min-
imum path sum proceeds from bottom to top. For each row, starting at the second
last and moving up, each element is summed with the smaller of the two elements
immediately below it. When the top (i.e., first) row is reached, the final sum
is guaranteed to be the minimum.

Output

If the constant $VERBOSE is given a true value, the output is supplemented with
a summary of the elements in the minimum path sum, followed by a table of moves
(left or right) from top to bottom of the triangle.

=cut
#==============================================================================

use strict;
use warnings;
use enum           qw( VALUE SUM INDEX );
use Const::Fast;
use Data::Dump     qw( pp );
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <triangle>

    <triangle>    String representing a non-empty triangular array of real
                  numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 100, Task #2: Triangle Sum (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @triangle = parse_command_line();

    printf "Input:  %s\n", pp( \@triangle );

    for my $col (0 .. scalar @{ $triangle[ $#triangle ] } - 1)
    {
        my $element =  \$triangle[$#triangle][$col];
          $$element = [ $$element, $$element, undef ];
    }

    for my $row (reverse 0 .. $#triangle - 1)
    {
        for my $col (0 .. scalar @{ $triangle[$row] } - 1)
        {
            my $lhs     =   $triangle[$row + 1][$col    ];
            my $rhs     =   $triangle[$row + 1][$col + 1];
            my $element =  \$triangle[$row    ][$col    ];

            my $left    =           $lhs->[SUM] <= $rhs->[SUM];  
            my $addend  =   $left ? $lhs->[SUM] :  $rhs->[SUM];
            my $new_col =   $left ? $col        :  $col + 1;

              $$element = [ $$element, $$element + $addend, $new_col ];
        }
    }

    printf "Output: %s\n", $triangle[0][0][SUM];

    show_path( \@triangle ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub show_path
#------------------------------------------------------------------------------
{
    my ($triangle) =  @_;
    my  $first     =  $triangle->[0][0][VALUE];
    my  @terms     = ($first);
    my  $path      = "\t          $first\n";
    my  $col       =  0;

    for my $row (1 .. $#$triangle)
    {
        my $next_col  =  $triangle->[$row - 1][$col][INDEX];
        my $direction = ($next_col == $col) ? 'Left' : (++$col, 'Right');

        push @terms, $triangle->[$row][$col][VALUE];

        $path .= sprintf "\t%-5s --> %s\n", $direction, $terms[-1];
    }

    my $sum  = 0;
       $sum += $_ for @terms;

    printf "\nThe minimum path from top to bottom: %s = %s\n\n\tMove      " .
             "Element\n\t%s\n%s", join(' + ', @terms), $sum, '-' x 17, $path;

    $sum == $triangle->[0][0][SUM] or die 'Logic error';         # Sanity check
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1  or error( "Expected 1 command-line argument, found $args" );

    my $str =  $ARGV[0];
       $str =~  / ^ \s* \[ .+ \] \s* $ /x    or error( 'Invalid input array' );
       $str =~ s/ ^ (     \s* \[ \s* \[ )   //x;
       $str =~ s/   ( \]  \s* \] \s*    ) $ //x;

    my @lines    = split / \] \, \s+ \[ /x, $str;
    my @triangle = map [ split /,/ ], @lines;

    defined $triangle[0] && scalar @{ $triangle[0] } == 1
                                             or error( 'Invalid first row' );

    for my $row (0 .. $#triangle)
    {
        my $cols = scalar @{ $triangle[$row] };
        my $row_ = $row + 1;

        $cols == $row_
            or error( sprintf 'Expected %d columns in row %d, found %d',
                               $row_, $row_, $cols );

        for my $col (0 .. $cols - 1)
        {
            my $element =  \$triangle[$row][$col];
              $$element =~ s/ ^ \s+   //x;
              $$element =~ s/   \s+ $ //x;
              $$element =~  / ^ $RE{num}{real} $ /x
                      or error( qq[Element "$$element" is not a real number] );
        }
    }

    return @triangle;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
