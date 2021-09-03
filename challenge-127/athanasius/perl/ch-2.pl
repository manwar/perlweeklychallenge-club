#!perl

###############################################################################
=comment

Perl Weekly Challenge 127
=========================

TASK #2
-------
*Conflict Intervals*

Submitted by: Mohammad S Anwar

You are given a list of intervals.

Write a script to find out if the current interval conflicts with any of the
previous intervals.

Example

 Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
 Output: [ (3,5), (3,20) ]

     - The 1st interval (1,4) do not have any previous intervals to compare
       with, so skip it.
     - The 2nd interval (3,5) does conflict with previous interval (1,4).
     - The 3rd interval (6,8) do not conflicts with any of the previous
       intervals (1,4) and (3,5), so skip it.
     - The 4th interval (12,13) again do not conflicts with any of the previous
       intervals (1,4), (3,5) and (6,8), so skip it.
     - The 5th interval (3,20) conflicts with the first interval (1,4).

 Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
 Output: [ (6,9) ]

     - The 1st interval (3,4) do not have any previous intervals to compare
       with, so skip it.
     - The 2nd interval (5,7) do not conflicts with the previous interval
       (3,4), so skip it.
     - The 3rd interval (6,9) does conflict with one of the previous intervals
       (5,7).
     - The 4th interval (10,12) do not conflicts with any of the previous
       intervals (3,4), (5,7) and (6,9), so skip it.
     - The 5th interval (13,15) do not conflicts with any of the previous
       intervals (3,4), (5,7), (6,9) and (10,12), so skip it.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
1. Interval endpoints must be integers.

2. Single-point intervals are allowed; e.g., (10, 10) is a valid interval.

3. An interval (a, b) has a <= b; so, if an interval is specified as (x, y)
   with x > y, this will be silently converted to the interval (y, x).

4. Two intervals with one shared endpoint but no additional overlap do not
   "conflict." For example, (5, 9) does NOT conflict with (9, 13).

5. All other overlaps constitute "conflicts"; for example:
     -- (5, 10) conflicts with (7, 15) because there is a partial overlap, the
                interval (7, 10)
     -- (5, 10) conflicts with (7,  9) because (5, 10) contains (7, 9)
     -- (5, 10) conflicts with (3, 20) because (5, 10) is contained by (3, 20)
     -- (5, 10) conflicts with (8,  8) because (8,  8) is contained by (5, 10)
                and the intervals do not share an endpoint.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<endpoints> ...]

    [<endpoints> ...]    An even-numbered list of interval endpoints " .
                                                                "(integers)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 127, Task #2: Conflict Intervals (Perl)\n\n";
}

#==============================================================================
package Interval;
#==============================================================================

#------------------------------------------------------------------------------
sub new
#------------------------------------------------------------------------------
{
    my ($class, $start, $end) = @_;
    my  %self;

    if ($start <= $end)
    {
        $self{ start } = $start;
        $self{ end   } = $end;
    }
    else
    {
        $self{ start } = $end;
        $self{ end   } = $start;
    }

    return bless \%self, $class;
}

#------------------------------------------------------------------------------
sub start                                                            # Accessor
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{ start };
}

#------------------------------------------------------------------------------
sub end                                                              # Accessor
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{ end };
}

#------------------------------------------------------------------------------
sub conflicts
#------------------------------------------------------------------------------
{
    my ($self, $rhs) = @_;

    return !( $self->end   <= $rhs->start ||
              $self->start >= $rhs->end );
}

#------------------------------------------------------------------------------
sub display
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return '(' . $self->start . ', ' . $self->end . ')';
}

#==============================================================================
package main;
MAIN:
#==============================================================================
{
    my @endpoints = parse_command_line();
    my @intervals;

    while (@endpoints)
    {
        push @intervals, Interval->new( shift @endpoints, shift @endpoints );
    }

    printf "Input:  \@Intervals = [ %s ]\n",
            join ', ', map { $_->display } @intervals;

    my @conflicts;

    L_OUTER:
    for my $i (1 .. $#intervals)
    {
        my $interval = $intervals[ $i ];

        for my $j (0 .. $i - 1)
        {
            if ($interval->conflicts( $intervals[ $j ] ))
            {
                push @conflicts, $interval;
                next L_OUTER;
            }
        }
    }

    printf "Output: \@Conflicts = [ %s ]\n",
            join ', ', map { $_->display } @conflicts;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args % 2 == 0
            or error( 'Expected an even number of command line arguments, ' .
                      "found $args" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
            or error( qq["$_" is not a valid integer] );
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
