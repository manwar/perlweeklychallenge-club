#!perl

###############################################################################
=comment

Perl Weekly Challenge 098
=========================

Task #2
-------
*Search Insert Position*

Submitted by: Mohammad S Anwar

You are given a sorted array of distinct integers @N and a target $N.

Write a script to return the index of the given target if found otherwise place
the target in the sorted array and return the index.

Example 1:

 Input: @N = (1, 2, 3, 4) and $N = 3
 Output: 2 since the target 3 is in the array at the index 2.

Example 2:

 Input: @N = (1, 3, 5, 7) and $N = 6
 Output: 3 since the target 6 is missing and should be placed at the index 3.

Example 3:

 Input: @N = (12, 14, 16, 18) and $N = 10
 Output: 0 since the target 10 is missing and should be placed at the index 0.

Example 4:

 Input: @N = (11, 13, 15, 17) and $N = 19
 Output: 4 since the target 19 is missing and should be placed at the index 4.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The index search is implemented using the List::MoreUtils first_index() sub-
routine. Note that first_index() "Returns -1 if no such item could be found",
which happens only when $N comes after the last list element. In this case, the
required index is one greater than the currently-highest list index.

Note: The Task description specifies:

    "Write a script to return the index of the given target if found otherwise
     place the target in the sorted array and return the index."

However, as the output required is the index only, there seems no point in
actually *inserting* $N into the array in the case where $N does not already
occur in @N. I interpret the Task description to mean "otherwise return the
index which $N would have if inserted into @N."

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use List::MoreUtils qw( first_index );
use Regexp::Common  qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [-N=<Int>] [<N> ...]

    -N=<Int>     The target integer
    [<N> ...]    A sorted list of distinct integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 098, Task #2: Search Insert Position (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($N, @N) = parse_command_line();

    printf "Input:  \@N = (%s) and \$N = %d\n", join(', ', @N), $N;

    my $msg = 'in the array';
    my $idx = first_index { $_ == $N } @N;

    if ($idx < 0)
    {
        $msg = 'missing and should be placed';
        $idx = first_index { $_ > $N } @N;
        $idx = $#N + 1 if $idx < 0;
    }

    printf "Output: $idx%s\n",
            $VERBOSE ? " since the target $N is $msg at the index $idx" : '';
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $N;

    GetOptions( 'N=i' => \$N ) or error( 'Invalid command-line argument' );
    defined $N                 or error( '$N is missing' );

    my @array = @ARGV;

    if (scalar @array > 0)
    {
        my $prev = $array[ 0 ];

        for my $i (1 .. $#array)
        {
            my $curr = $array[ $i ];

            $prev == $curr and error( 'The list elements are not distinct' );
            $prev >  $curr and error( 'The list is not correctly sorted'   );
            $prev =  $curr;
        }
    }

    return ($N, @array);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
