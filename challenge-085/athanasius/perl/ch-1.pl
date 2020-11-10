#!perl

###############################################################################
=comment

Perl Weekly Challenge 085
=========================

Task #1
-------
*Triplet Sum*

Submitted by: Mohammad S Anwar

You are given an array of real numbers greater than zero.

Write a script to find if there exists a triplet (a,b,c) such that 1 < a+b+c <
2. Print 1 if you succeed otherwise 0.

Example 1:

 Input: @R = (1.2, 0.4, 0.1, 2.5)
 Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2

Example 2:

 Input: @R = (0.2, 1.5, 0.9, 1.1)
 Output: 0

Example 3:

 Input: @R = (0.5, 1.1, 0.3, 0.7)
 Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

=cut
###############################################################################

#==============================================================================
=comment

Assumption:
A "triplet" is a *contiguous* sequence of 3 elements in the array.

Note:
If more than one triplet satisfies the requirement (and assuming $EXPLAIN is
set to a true value), then only the first such triplet will be shown in the
explanation.

=cut
#==============================================================================

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use Regexp::Common qw( number );       # %RE{num}

const my $EXPLAIN => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<R> ...]

    [<R> ...]    An array of real numbers greater than zero\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 085, Task #1: Triplet Sum (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @R = parse_command_line();

    # Add zero to each real number to convert it to its decimal representation
    # (where possible); e.g., 1e-4 --> 0.0001 but 1e-5 --> 1e-05

    printf "Input:  \@R = (%s)\n", join ', ', map { $_ + 0 } @R;

    if (my $index = search_for_triplet(\@R) < 0)   # -ve index means no triplet
    {
        print  "Output: 0\n";
    }
    elsif ($EXPLAIN)
    {
        my @triplet = @R[$index .. $index + 2];
        my $sum     = 0;
           $sum    += $_ for @triplet;

        printf "Output: 1 as 1 < (%s = %f) < 2\n", join(' + ', @triplet), $sum;
    }
    else
    {
        print  "Output: 1\n";
    }
}

#------------------------------------------------------------------------------
sub search_for_triplet
#------------------------------------------------------------------------------
{
    my ($R)  = @_;
    my  $idx = -1;        # Array index of the first triplet element; -1 = none

    if (scalar @$R >= 3)
    {
        for my $i (0 .. $#$R - 2)
        {
            my $sum = $R->[$i] + $R->[$i + 1] + $R->[$i + 2];

            # Note: From Perl v5.32.0, this can be simplified to:
            #       if (1 < $sum < 2)

            if (1 < $sum && $sum < 2)
            {
                $idx = $i;
                last;
            }
        }
    }

    return $idx;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / \A $RE{num}{real} \z /x
               or die qq[ERROR: "$_" is not a real number\n$USAGE];

        $_ > 0 or die qq[ERROR: "$_" is not greater than zero\n$USAGE];
    }

    return @ARGV;
}

###############################################################################
