#!perl

###############################################################################
=comment

Perl Weekly Challenge 106
=========================

Task #1
-------
*Maximum Gap*

Submitted by: Mohammad S Anwar

You are given an array of integers @N.

Write a script to display the maximum difference between two successive
elements once the array is sorted.

If the array contains only 1 element then display 0.

Example

 Input: @N = (2, 9, 3, 5)
 Output: 4

 Input: @N = (1, 3, 8, 2, 0)
 Output: 5

 Input: @N = (5)
 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Straightforward: Sort the array in ascending order, then iterate through all
pairs of adjacent elements and record the largest gap. Default to zero if there
is only one element in the array.

Note on Duplicates
------------------
For large arrays containing many duplicate elements, it might be possible to
obtain a small speed-up by removing duplicates from the sorted array before
testing adjacent elements. The (optional) flag --u[nique] (or just -u) is
provided for this purpose. It defaults to a false value, since for small arrays
the speed-up is likely more than outweighed by the overhead of duplicate
removal.

Command Line Usage
------------------
Note that if the --unique flag is given and the list contains negative numbers,
the list must be preceded by -- to prevent the minus sign from being interpret-
ed as introducing a command line option.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( uniqint );
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [--unique --] [<N> ...]

    --unique     (Optional) remove duplicates
    [<N> ...]    A non-empty, unsorted list of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 106, Task #1: Maximum Gap (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($unique, $N) = parse_command_line();

    printf "Input:  \@N = (%s)\n", join ', ', @$N;

    my @sorted  = sort { $a <=> $b } @$N;              # Sort ascending
       @sorted  = uniqint @sorted if $unique;          # Optionally remove dups
    my $max_gap = 0;

    # Test every difference between successive elements in the sorted array

    for my $i (1 .. $#sorted)
    {
        my $diff = $sorted[ $i ] - $sorted[ $i - 1 ];

        $max_gap = $diff if $diff > $max_gap;
    }

    print "Output: $max_gap\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $unique = 0;

    GetOptions( 'unique'  => \$unique )
                  or error( 'Unrecognized command line argument' );

    my @N = @ARGV;

    scalar @N > 0 or error( 'Empty list' );

    for my $n (@N)
    {
        $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq[List element "$n" is not an integer] );
    }

    return ($unique, \@N);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
