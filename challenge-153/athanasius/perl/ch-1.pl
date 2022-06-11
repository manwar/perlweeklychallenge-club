#!perl

###############################################################################
=comment

Perl Weekly Challenge 153
=========================

TASK #1
-------
*Left Factorials*

Submitted by: Mohammad S Anwar

Write a script to compute Left Factorials of 1 to 10. Please refer 
[ http://oeis.org/A003422 |OEIS A003422] for more information.

Expected Output:

 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
On each iteration of the main loop, the next factorial is computed, then it is
added to the cumulative sum to give the next left factorial.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $TARGET => 10;
const my $USAGE  =>
"Usage:
  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 153, Task #1: Left Factorials (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @left_facts = (1);           # !1 = 0! = 1
    my $factorial  =  1;            # Last factorial
    my $cum_sum    =  1;            # Cumulative sum of factorials

    for my $n (1 .. $TARGET - 1)    # Compute !2 to !$TARGET
    {
        $factorial *= $n;
        $cum_sum   += $factorial;

        push @left_facts, $cum_sum;
    }

    print "The left factorials of 1 to $TARGET:\n";
    print  join( ', ', @left_facts ), "\n";
}

###############################################################################
