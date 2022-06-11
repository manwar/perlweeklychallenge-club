#!perl

###############################################################################
=comment

Perl Weekly Challenge 163
=========================

TASK #2
-------
*Summations*

Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n.

Write a script to find out the summations as described below.

Example 1

  Input: @n = (1, 2, 3, 4, 5)
  Output: 42

      1 2 3  4  5
        2 5  9 14
          5 14 28
            14 42
               42

  The nth Row starts with the second element of the (n-1)th row.
  The following element is sum of all elements except first element of previous
  row.
  You stop once you have just one element in the row.

Example 2

  Input: @n = (1, 3, 5, 7, 9)
  Output: 70

      1 3  5  7  9
        3  8 15 24
           8 23 47
             23 70
                70

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
"Positive numbers" are integers greater than zero.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<n> ...]

    [<n> ...]    A list of positive integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 163, Task #2: Summations (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @n = parse_command_line();

    printf "Input:  \@n = (%s)\n", join ', ', @n;

    my @last     = @n;
    my @next     = $last[ 1 ];
    my @triangle = [ @last ];

    while (scalar @last > 1)
    {
        push @next, $next[ $_ - 2 ] + $last[ $_ ] for 2 .. $#last;
        push @triangle,  [ @next ];

        @last = @next;
        @next = $last[ 1 ];
    }

    printf "Output: %d\n", $triangle[ -1 ][ 0 ];

    display_triangle( \@triangle ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub display_triangle
#------------------------------------------------------------------------------
{
    my ($triangle) = @_;

    # Pre-calculate the maximum width of each column

    my @col_widths;

    for my $col (0 .. $#{ $triangle->[ 0 ] })
    {
        $col_widths[ $col ] = length $triangle->[ $col ][ 0 ];
    }

    # Print the triangle

    print "\n";
    my $row_idx = 0;

    for my $row (@$triangle)
    {
        print '   ';

        for my $i (0 .. $row_idx - 1)
        {
            printf ' %*s', $col_widths[ $i ], '';
        }

        for my $j (0 .. $#$row)
        {
            printf ' %*s', $col_widths[ $j + $row_idx ], $row->[ $j ];
        }

        print "\n";
        ++$row_idx;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    @ARGV      or error( 'No command line arguments found' );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
               or error( qq["$_" is not a valid integer] );

        $_ > 0 or error( qq["$_" is not positive] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
