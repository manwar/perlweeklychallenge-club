#!perl

################################################################################
=comment

Perl Weekly Challenge 333
=========================

TASK #1
-------
*Straight Line*

Submitted by: Mohammad Sajid Anwar

You are given a list of co-ordinates.

Write a script to find out if the given points make a straight line.

Example 1

  Input: @list = ([2, 1], [2, 3], [2, 5])
  Output: true

Example 2

  Input: @list = ([1, 4], [3, 4], [10, 4])
  Output: true

Example 3

  Input: @list = ([0, 0], [1, 1], [2, 3])
  Output: false

Example 4

  Input: @list = ([1, 1], [1, 1], [1, 1])
  Output: true

Example 5

  Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of coordinate strings is entered on the command-line.
3. If the first coordinate string begins with a hyphen (because the x-coordin-
   ate is negative), it must be preceded by "--" to indicate that it is not a
   command-line flag.

Assumptions
-----------
1. The coordinates represent points on the Cartesian plane; therefore, coordin-
   ate values are real numbers.
2. Degenerate cases: if there are only 1 or 2 (distinct) coordinates, they are
   deemed to be collinear.

Note
----
This script handles real number co-ordinate values using Perl's built-in float- ing-point arithmetic. For this reason, equality comparison cannot be performed
reliably using the "==" operator; instead, an equal_values() subroutine is pro-
vided. If the absolute difference between the values to be compared is less than
a given $EPSILON, then the values are considered equal.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $EPSILON => 1e-10;
const my $USAGE   => <<END;
Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A non-empty list of co-ordinate strings (e.g., "1 2" "3 4")
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 333, Task #1: Straight Line (Perl)\n\n";
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
        my @list   = @ARGV;
        my $coords = get_coords( \@list );

        printf "Input:  \@list = (%s)\n",
                join ', ', map { '[' . join( ', ', @$_ ) . ']' } @$coords;

        my $collinear = are_collinear( $coords );

        printf "Output: %s\n", $collinear ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub are_collinear
#-------------------------------------------------------------------------------
{
    my ($list)  = @_;
    my  $coords = remove_duplicates( $list );

    if (scalar @$coords > 2)
    {
        my $x0 = $coords->[ 0 ][ 0 ];
        my $y0 = $coords->[ 0 ][ 1 ];
        my $x1 = $coords->[ 1 ][ 0 ];
        my $y1 = $coords->[ 1 ][ 1 ];
        my $m0 = equal_values( $x0, $x1 ) ? undef : ($y1 - $y0) / ($x1 - $x0);

        for my $i (2 .. $#$coords)
        {
            my $xi  = $coords->[ $i ][ 0 ];
            my $yi  = $coords->[ $i ][ 1 ];
            my $lhs = $xi;                         # Assume the line is vertical
            my $rhs = $x0;

            if (defined $m0)                       # It's not
            {
                $lhs = ($yi - $y0) / ($xi - $x0);
                $rhs =  $m0;
            }

            return '' unless equal_values( $lhs, $rhs );
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub remove_duplicates
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  @unique;

    for my $coord (@$list)
    {
        my $found = '';

        for my $uniq (@unique)
        {
            if (equal_coords( $uniq, $coord ))
            {
                $found = 1;
                last;
            }
        }

        push @unique, $coord unless $found;
    }

    return \@unique;
}

#-------------------------------------------------------------------------------
sub equal_coords
#-------------------------------------------------------------------------------
{
    my ($p, $q) = @_;

    return equal_values( $p->[ 0 ], $q->[ 0 ] ) &&
           equal_values( $p->[ 1 ], $q->[ 1 ] );
}

#-------------------------------------------------------------------------------
sub equal_values
#-------------------------------------------------------------------------------
{
    my ($x, $y) = @_;

    return abs( $x - $y ) < $EPSILON;
}

#-------------------------------------------------------------------------------
sub get_coords
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  @coords;

    for my $str (@$list)
    {
        my @pair = grep { / \S /x } split / \s+ /x, $str;

        scalar @pair == 2 or error( qq[Invalid coordinate string "$str"] );

        for (@pair)
        {
            / ^ $RE{num}{real} $ /x
                          or error( qq["$_" is not a valid coordinate value] );
        }

        push @coords, [ map { $_ + 0 } @pair ];     # Normalize the coord values
    }

    return \@coords;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $coord_str, $expected) = split / \| /x, $line;

        for ($test_name, $coord_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list      = split / ; /x, $coord_str;
        my $coords    = get_coords( \@list );
        my $collinear = are_collinear( $coords ) ? 'true' : 'false';

        is $collinear, $expected, $test_name;
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
Example 1  | 2 1; 2 3;  2 5                                  |true
Example 2  | 1 4; 3 4; 10 4                                  |true
Example 3  | 0 0; 1 1;  2 3                                  |false
Example 4  | 1 1; 1 1;  1 1                                  |true
Example 5  |1000000 1000000; 2000000 2000000; 3000000 3000000|true
Duplicate 1| 1 2; 1 2;  2 3; 3 4                             |true
Duplicate 2| 1 2; 1 2;  2 3; 3 5                             |false
Duplicate 3| 1 2; 1 2;  2 3; 1 2                             |true
Singleton  | 4 9                                             |true
Pair       | 4 9; 7 6                                        |true
Reals      |-1.5 0.3; -2.5 -0.7; -3.5 -1.7                   |true
