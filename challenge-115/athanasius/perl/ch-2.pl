#!perl

###############################################################################
=comment

Perl Weekly Challenge 115
=========================

TASK #2
-------
*Largest Multiple*

Submitted by: Mohammad S Anwar

You are given a list of positive integers (0-9), single digit.

Write a script to find the largest multiple of 2 that can be formed from the
list.

Examples

 Input: @N = (1, 0, 2, 6)
 Output: 6210

 Input: @N = (1, 4, 2, 8)
 Output: 8412

 Input: @N = (4, 1, 7, 6)
 Output: 7614

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Observations
------------
1. To be a multiple of 2, an integer must end in an even digit: 0, 2, 4, 6, or
   8.
2. When forming an integer from available digits, the largest integer is formed
   by placing the largest digit in the most significant place, followed by the
   next-largest digit in the next-most-significant place, and so on.

Algorithm
---------
1. Find the least significant digit: this is the smallest even digit among the
   available digits. If no even digit is available, no solution is possible.
2. Form a string S by concatenating the remaining digits in descending order.
3. Append the least significant digit (found in step 1) to S. The resulting
   string is (a string representation of) the solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    A non-empty list of digits\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 115, Task #2: Largest Multiple (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = parse_command_line();

    printf "Input:  \@N = (%s)\n", join ', ', @N;

    my %digits;                       # Hash emulating a multiset
     ++$digits{ $_ } for @N;

    my $lsdig;                        # Least significant digit: must be even

    for my $d (keys %digits)
    {
        $lsdig = $d if ($d % 2 == 0) && (!defined( $lsdig ) || $d < $lsdig);
    }

    if (defined $lsdig)
    {
        --$digits{ $lsdig };          # Remove the least significant digit from
                                      #   the multiset
        my @msdigs;                   # The remaining (i.e., most sig.) digits

        for my $d (keys %digits)      # Build the array from the multiset
        {
            push @msdigs, $d for 1 .. $digits{ $d };
        }

        printf "Output: %s%d\n", join( '', sort { $b <=> $a } @msdigs ),
                                 $lsdig;
    }
    else
    {
        print 'Output: None (no multiple of 2 can be formed from the given ' .
              "digits)\n";
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0 or error( 'No command line arguments given' );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                     or error( qq["$_" is not a valid integer] );

        0 <= $_ <= 9 or error( qq["$_" is not a valid digit] );
    }

    return map { $_ + 0 } @ARGV;                # Normalize, e.g., '+05' -> '5'
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
