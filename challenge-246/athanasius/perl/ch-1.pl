#!perl

################################################################################
=comment

Perl Weekly Challenge 246
=========================

TASK #1
-------
*6 out of 49*

Submitted by: Andreas Voegele

6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

Output

   3
  10
  11
  22
  38
  49

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
From the sample output, it appears that the selected integers should be display-
ed in ascending numerical order.

=cut
#===============================================================================

use v5.32.1;        # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( shuffle );
use Test::More;

const my $START  =>  1;
const my $END    => 49;
const my $SELECT =>  6;
const my $USAGE  =>
"Usage:
  perl $0\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 246, Task #1: 6 out of 49 (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        print "Output\n\n";

        my @selection = (shuffle( $START .. $END ))[ 0 .. $SELECT - 1 ];
           @selection =  sort { $a <=> $b } @selection;

        printf "  %2d\n", $_ for @selection;
    }
    else
    {
        die "ERROR: Command-line argument(s) found\n$USAGE";
    }
}

################################################################################
