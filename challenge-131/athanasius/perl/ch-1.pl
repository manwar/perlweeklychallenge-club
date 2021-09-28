#!perl

###############################################################################
=comment

Perl Weekly Challenge 131
=========================

TASK #1
-------
*Consecutive Arrays*

Submitted by: Mark Anderson

You are given a sorted list of unique positive integers.

Write a script to return list of arrays where the arrays are consecutive
integers.

Example 1:

 Input:  (1, 2, 3, 6, 7, 8, 9)
 Output: ([1, 2, 3], [6, 7, 8, 9])

Example 2:

 Input:  (11, 12, 14, 17, 18, 19)
 Output: ([11, 12], [14], [17, 18, 19])

Example 3:

 Input:  (2, 4, 6, 8)
 Output: ([2], [4], [6], [8])

Example 4:

 Input:  (1, 2, 3, 4, 5)
 Output: ([1, 2, 3, 4, 5])

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
The input must be a list of unsigned integers. Any duplicates will be silently
removed, and the list will be sorted in increasing numerical order, before it
is processed.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( uniqint );
use Regexp::Common qw( number  );

const my $USAGE =>
"Usage:
  perl $0 [<list> ...]

    [<list> ...]    A list of unsigned integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 131, Task #1: Consecutive Arrays (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @list   = parse_command_line();
    my @sorted = sort { $a <=> $b } uniqint @list;

    printf "Input:  (%s)\n", join ', ', @sorted;

    my @consec = get_consecutive_arrays( @sorted );

    printf "Output: (%s)\n",
        join ', ', map { '[' . join( ', ', @$_ ) . ']' } @consec;
}

#------------------------------------------------------------------------------
sub get_consecutive_arrays
#------------------------------------------------------------------------------
{
    my  @sorted = @_;
    my (@consec, @range, $last);

    for my $value (@sorted)
    {
        if (!defined( $last ) || $last == $value - 1)
        {
            push @range, $value;
        }
        else
        {
            push @consec, [ @range ];        # Save a copy of the current range
            @range = $value;                 # Begin the next range
        }

        $last = $value;
    }

    push @consec, \@range;

    return @consec;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
            or error( qq["$_" is not a valid integer] );

        $_ >= 0
            or error( qq["$_" is not a positive integer] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "\nERROR: $message\n$USAGE";
}

###############################################################################
