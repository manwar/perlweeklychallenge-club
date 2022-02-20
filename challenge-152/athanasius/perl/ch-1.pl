#!perl

###############################################################################
=comment

Perl Weekly Challenge 152
=========================

TASK #1
-------
*Triangle Sum Path*

Submitted by: Mohammad S Anwar

You are given a triangle array.

Write a script to find the minimum sum path from top to bottom.

Example 1:

 Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]

                 1
                5 3
               2 3 4
              7 1 0 2
             6 4 5 2 8

 Output: 8

     Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8

Example 2:

 Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]

                 5
                2 3
               4 1 5
              0 1 2 3
             7 2 4 1 9

 Output: 9

     Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. Following the Examples, I have assumed that array elements are integers.
2. The array elements are entered on the command line as a linear sequence
   beginning with the top-most element and continuing down and to the right
   until the final (bottom- and right-most) element. For example, the triangu-
   lar array:   1
               2 3
              4 5 6     is entered as:  perl ch-1.pl 1 2 3 4 5 6
3. If the constant $VERBOSE is set to a true value (the default), the individ-
   ual elements comprising the minimum sum path are shown in addition to the
   minimum sum.

Algorithm
---------
From the Examples, it appears that a "path" is simply a selection of elements
drawn from the triangular array, with exactly one element drawn from each array
level. Hence, the solution is found by taking the smallest element from each
level, and summing these elements.

The following test is used to determine whether the number of elements entered
on the command line is a triangular number:

    "... an integer _x_ is triangular if and only if 8_x_ + 1 is a square." [1]

Reference
---------
[1] https://en.wikipedia.org/wiki/Triangular_number#Triangular_roots_and_tests_
    for_triangular_numbers

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<items> ...]

    [<items> ...]    A triangular array of integers, in linear order\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 152, Task #1: Triangle Sum Path (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $items    = parse_command_line();
    my $triangle = build_triangle( $items );

    printf "Input:  \$triangle = %s\n", sprint_triangle( $triangle );

    my   @min_sum_path;
    push @min_sum_path, min( $triangle->[ $_ ]->@* ) for 0 .. $#$triangle;

    my $min_sum  = 0;
       $min_sum += $_ for @min_sum_path;

    print "Output: $min_sum\n";

    if ($VERBOSE)
    {
        printf "\n    Minimum Sum Path: %s = %d\n",
                join( ' + ', @min_sum_path ), $min_sum;
    }
}

#------------------------------------------------------------------------------
sub build_triangle
#------------------------------------------------------------------------------
{
    my ($items)   = @_;
    my  $row_idx  = 0;
    my  $index    = 0;
    my  @triangle;

    while ($index <= $#ARGV)
    {
        my   @row;
        push @row, $items->[ $index++ ] for 1 .. $row_idx + 1;
        push @triangle, [ @row ];

        ++$row_idx;
    }

    return \@triangle;
}

#------------------------------------------------------------------------------
sub sprint_triangle
#------------------------------------------------------------------------------
{
    my ($triangle) = @_;

    my @rows;

    for my $row (@$triangle)
    {
        push @rows, '[' . join( ',', @$row ) . ']';
    }

    return '[ ' . join( ', ', @rows ) . ' ]';
}

#------------------------------------------------------------------------------
sub min
#------------------------------------------------------------------------------
{
    my @array = @_;
    my $min   = shift @array;

    for (@array)
    {
        $min = $_ if $_ < $min;
    }

    return $min;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args > 0 or error( 'No command line arguments' );

    is_triangular( $args )
                 or error( "Array size ($args) is not a triangular number" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                 or error( qq["$_" is not a valid integer] );
    }

    return \@ARGV;
}

#------------------------------------------------------------------------------
sub is_triangular
#------------------------------------------------------------------------------
{
    my ($num) = @_;
    my  $x    = 8 * $num + 1;
    my  $root = int sqrt $x;

    return $root * $root == $x;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
