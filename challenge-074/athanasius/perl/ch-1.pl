#!perl

################################################################################
=comment

Perl Weekly Challenge 074
=========================

Task #1
-------
*Majority Element*

Submitted by: Mohammad S Anwar

You are given an array of integers of size _$N_.

Write a script to find the majority element. If none found then print -1.

    Majority element in the list is the one that appears more than
    floor(size_of_list/2).

Example 1

Input: @A = (1, 2, 2, 3, 2, 4, 2)
Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).

Example 2

Input: @A = (1, 3, 1, 2, 4, 5)
Output: -1 as none of the elements appears more than floor(6/2).

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;                    # Exports const()
use List::Util     qw( max    );
use POSIX          qw( floor  );
use Regexp::Common qw( number );    # Exports %RE{num}

const my $USAGE =>
"Usage:
  perl $0 [<A> ...]

    [<A> ...]    Non-empty integer sequence\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 074, Task #1: Majority Element (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my @A = @ARGV;
   (my $N = scalar @A) > 0 or die $USAGE;
    /\A$RE{num}{int}\z/    or die $USAGE for @A;

    my $mean_fl = floor($N / 2);
    my $output  = -1;
    my %count;
     ++$count{$_} for @A;

    if ((my $max = max values %count) > $mean_fl)
    {
        my %rev = reverse %count;
        $output = $rev{$max};
    }

    printf "Input:  \@A = (%s)\nOutput: %d\n", join(', ', @A), $output;
}

################################################################################
