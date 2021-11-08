#!perl

###############################################################################
=comment

Perl Weekly Challenge 122
=========================

TASK #1
-------
*Average of Stream*

Submitted by: Mohammad S Anwar

You are given a stream of numbers, @N.

Write a script to print the average of the stream at every point.

Example

 Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
 Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...

 Average of first number is 10.
 Average of first 2 numbers (10+20)/2 = 15
 Average of first 3 numbers (10+20+30)/3 = 20
 Average of first 4 numbers (10+20+30+40)/4 = 25 and so on.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    A stream of numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 122, Task #1: Average of Stream (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = parse_command_line();

    printf "Input: \@N = (%s)\n", join ', ', @N;
    print  'Output:      ';

    my $sum   = 0;
    my $count = 0;

    for my $n (@N)
    {
        $sum += $n;

        my $average = $sum / ++$count;

        print ', ' if $count > 1;
        print $average;
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{real} $ /x
            or die qq["$_" is not a valid number\n$USAGE];
    }

    return @ARGV;
}

###############################################################################
