#!perl

###############################################################################
=comment

Perl Weekly Challenge 080
=========================

Task #1
-------
*Smallest Positive Number Bits*

Submitted by: Mohammad S Anwar

You are given unsorted list of integers @N.

Write a script to find out the smallest positive number missing.

Example 1:

 Input: @N = (5, 2, -2, 0)
 Output: 1

Example 2:

 Input: @N = (1, 8, -1)
 Output: 2

Example 3:

 Input: @N = (2, 0, -1)
 Output: 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use Regexp::Common qw( number );       # %RE{num}

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    An unsorted list of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 080, Task #1: Smallest Positive Number Bits (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = @ARGV;
    /\A$RE{num}{int}\z/ or die "ERROR: Non-integer '$_'\n$USAGE" for @N;

    printf "Input: \@N = (%s)\n", join(', ', @N);

    my %N;                                          # Make a dictionary of the
     ++$N{ $_ } for @N;                             #   listed integers

    my $num = 1;                                    # Find the lowest integer >
     ++$num while exists $N{ $num };                #   0 not in the list

    print "Output: $num\n";
}

###############################################################################
