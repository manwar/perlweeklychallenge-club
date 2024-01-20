#!perl

################################################################################
=comment

Perl Weekly Challenge 252
=========================

TASK #2
-------
*Unique Sum Zero*

Submitted by: Mohammad S Anwar

You are given an integer, $n.

Write a script to find an array containing $n unique integers such that they add
up to zero.

Example 1

  Input: $n = 5
  Output: (-7, -1, 1, 3, 4)

  Two other possible solutions could be as below:
  (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).

Example 2

  Input: $n = 3
  Output: (-1, 0, 1)

Example 3

  Input: $n = 1
  Output: (0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
It is assumed that the output list contains at least one element, and therefore
that $n > 0.

Interface
---------
1. A single, non-zero, positive integer should be entered on the command-line.
2. No test suite is provided, as the output is randomized. Instead, if the
   constant $DEBUG is set to a true value, the generated solution is validated
   to ensure that it contains exactly $n unique elements that sum to zero.
3. The constant $COEFF may be adjusted to vary the range of potential output
   values. For example, if $n = 4 and $COEFF = 2.5, the integers in the solution
   will be drawn from the range -10 .. +10.

=cut
#===============================================================================

use v5.32.1;        # Enables strictures
use warnings;
use Const::Fast;
use List::Util      qw( none shuffle sum0 );
use Regexp::Common  qw( number );

const my $COEFF => 2.5;       # Determines the range of possible solution values
const my $DEBUG => 1;

const my $USAGE => <<END;
Usage:
  perl $0 <n>

    <n>    A non-zero, positive integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 252, Task #2: Unique Sum Zero (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;
       $argc == 1 or error( "Expected 1 command-line argument, found $argc" );

    my $n = $ARGV[ 0 ];
       $n =~ / ^ $RE{num}{int} $ /x or error( qq["$n" is not a valid integer] );
       $n > 0                       or error( qq["$n" is too small] );

    print "Input:  \$n = $n\n";

    my $zero_sum_list = find_zero_sum_list( $n );

    printf "Output: (%s)\n", join ', ', @$zero_sum_list;

    validate( $n, $zero_sum_list )
        or die 'Solution failed validation' if $DEBUG;
}

#-------------------------------------------------------------------------------
sub find_zero_sum_list
#-------------------------------------------------------------------------------
{
    my ($n)  = @_;
    my  $max = int( $COEFF * $n );
    my  @zero_sum_list;

    for (my $done = 0; !$done; )
    {
        my @candidates    = -$max .. +$max;
           @zero_sum_list = (shuffle @candidates)[ 0 .. $n - 2 ];
        my $diff          = - sum0 @zero_sum_list;

        # Ensure that $diff is (1) not already in @zero_sum
        #                  and (2) within the specified range

        if ((none { $_ == $diff } @zero_sum_list) && (abs $diff <= $max))
        {
            push @zero_sum_list, $diff;
            $done = 1;
        }
    }

    return \@zero_sum_list;
}

#-------------------------------------------------------------------------------
sub validate
#-------------------------------------------------------------------------------
{
    my ($n, $zero_sum_list) = @_;

    # 1. n elements

    return 0 unless scalar @$zero_sum_list == $n;

    # 2. Unique

    my %dict;

    for my $elem (@$zero_sum_list)
    {
        return 0 unless ++$dict{ $elem } == 1;
    }

    # 3. Add up to zero

    my $sum = sum0 @$zero_sum_list;

    return $sum == 0;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################
