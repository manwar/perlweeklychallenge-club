#!perl

###############################################################################
=comment

Perl Weekly Challenge 078
=========================

Task #1
-------
*Leader Element*

Submitted by: Mohammad S Anwar

You are given an array @A containing distinct integers.

Write a script to find all leader elements in the array @A. Print (0) if none
found.

        An element is leader if it is greater than all the elements to its
        right side.

Example 1:

 Input: @A = (9, 10, 7, 5, 6, 1)
 Output: (10, 7, 6, 1)

Example 2:

 Input: @A = (3, 4, 5)
 Output: (5)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----

If @A contains a single element only, that element is (trivially) "greater than
all the elements to its right side." The array @A is specified to contain
"distinct integers." Since 0 is an integer, a correct solution could be:

 Input: @A = (0)
 Output: (0)

But an empty array is still an array, and therefore a legal input. Further, an
empty array is the only input for which no leader element can be found. Since
an output of (0) [as specified in the Task] would be identical to the output
for @A = (0), as explained above, I have departed from the specification and
output:

 Input: @A = ()
 Output: ()

in this case.

=cut
#==============================================================================

                                    # Exports:
use strict;
use warnings;
use Const::Fast;                    # const()
use List::Util     qw( uniqint );
use Regexp::Common qw( number );    # %RE{num}

#------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------

const my $USAGE =>
"Usage:
  perl $0 [<A> ...]

    [<A> ...]    A list of distinct integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 078, Task #1: Leader Element (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @A = parse_command_line();

    printf "Input: \@A = (%s)\n", join(', ', @A);

    my @leaders;

    OUTER_FOR: for my $i (0 .. $#A)
    {
        for my $j ($i + 1 .. $#A)
        {
            next OUTER_FOR unless $A[$i] > $A[$j];
        }

        push @leaders, $A[$i];
    }

    printf "Output:     (%s)\n", join(', ', @leaders);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @A = @ARGV;

    for (@A)
    {
        / \A $RE{num}{int} \z /x or die "ERROR: Non-integer found\n$USAGE";
    }

    my @subset = uniqint @A;

    scalar @subset == scalar @A  or die "ERROR: Duplicate(s) found\n$USAGE";

    return @A;
}

###############################################################################
