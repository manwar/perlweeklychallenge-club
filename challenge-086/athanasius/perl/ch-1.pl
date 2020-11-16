#!perl

###############################################################################
=comment

Perl Weekly Challenge 086
=========================

Task #1
-------
*Pair Difference*

Submitted by: Mohammad S Anwar

You are given an array of integers @N and an integer $A.

Write a script to find if there exists a pair of elements in the array whose
difference is $A.

Print 1 if exists otherwise 0.

Example 1:

 Input: @N = (10, 8, 12, 15, 5) and $A = 7
 Output: 1 as 15 - 8 = 7

Example 2:

 Input: @N = (1, 5, 2, 9, 7) and $A = 6
 Output: 1 as 7 - 1 = 6

Example 3:

 Input: @N = (10, 30, 20, 50, 40) and $A = 15
 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption: The pair must be different (but possibly equal) elements in the
            array

Algorithm:  Exhaustive comparison of each pair difference, together with its
            negation, until a solution is found or all pairs have been examined

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );

const my $EXPLAIN => 1;
const my $USAGE   =>
"Usage:
  perl $0 -A=<Int> -- [<N> ...]

    -A=<Int>     A possible difference between two elements in \@N
    [<N> ...]    An array of two or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 086, Task #1: Pair Difference (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($N, $A) = parse_command_line();

    printf "Input:  \@N = (%s) and \$A = %d\n", join(', ', @$N), $A;

    my ($minuend, $subtrahend) = find_pair($N, $A);

    if (defined $minuend && defined $subtrahend)
    {
        if ($EXPLAIN)
        {
            print "Output: 1 as $minuend - $subtrahend = $A\n";
        }
        else
        {
            print "Output: 1\n";
        }
    }
    else
    {
        print "Output: 0\n";
    }
}

#------------------------------------------------------------------------------
sub find_pair
#------------------------------------------------------------------------------
{
    my ($N, $A) = @_;
    my ($minuend, $subtrahend);

    OUTER:
    for my $i (0 .. $#$N - 1)
    {
        for my $j ($i + 1 .. $#$N)
        {
            my $difference = $N->[$i] - $N->[$j];

            if    ($difference ==  $A)
            {
                $minuend    = $N->[$i];
                $subtrahend = $N->[$j];
                last OUTER;
            }
            elsif ($difference == -$A)
            {
                $minuend    = $N->[$j];
                $subtrahend = $N->[$i];
                last OUTER;
            }
        }
    }

    return ($minuend, $subtrahend);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $A;

    GetOptions('A=i' => \$A)       or error('Incorrect command line argument');

    defined $A                     or error('Missing $A');

    $A =~ /\A$RE{num}{int}\z/      or error("\$A ($A) is not an integer");

    my @N = @ARGV;

    scalar @N >= 2                 or error('Too few elements in @N');

    for my $n (@N)
    {
        $n =~ /\A$RE{num}{int}\z/  or error("\"$n\" is not an integer");
    }

    return (\@N, $A);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
