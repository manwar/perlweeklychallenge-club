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

Note
----
This alternative solution to Task 1 is provided only for interest; it is less
efficient than the solution provided in "ch-1.pl".

Algorithm
---------
From OEIS A003422 [1]:

   "Also, numbers left over after the following sieving process: At step 1,
    keep all numbers of the set N = {0, 1, 2, ...}. In step 2, keep only every
    second number after a(2) = 2: N' = {0, 1, 2, 4, 6, 8, 10, ...}. In step 3,
    keep every third of the numbers following a(3) = 4, N" = {0, 1, 2, 4, 10,
    16, 22, ...}. In step 4, keep every fourth of the numbers beyond a(4) = 10:
    {0, 1, 2, 4, 10, 34, 58, ...}, and so on. - M. F. Hasler, Oct 28 2010"

Reference
---------
[1] OEIS:  A003422  Left factorials: !n = Sum_{k=0..n-1} k!.
    (http://oeis.org/A003422)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $TARGET     => 10;
const my $SIEVE_SIZE => 410_000;
const my $USAGE      =>
"Usage:
  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 153, Task #1a: Left Factorials (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @sieve = 0 .. $SIEVE_SIZE;

    for my $step (2 .. $TARGET - 1)
    {
        # Find the index of a(step)

        my $i     = 0;
        my $count = $step;

        while ($count > 0)
        {
            --$count if defined $sieve[ ++$i ];
        }

        # Beginning at the first defined number beyond a(step): for each
        # consecutive set of step defined numbers, remove all but the last

        while ($i < $#sieve)
        {
            $count = $step;

            while ($count > 0 && $i < $#sieve)
            {
                if (defined $sieve[ ++$i ])
                {
                    $sieve[ $i ] = undef unless --$count == 0;
                }
            }
        }
    }

    my @left_facts = grep { defined $_ } @sieve;

    print "The left factorials of 1 to $TARGET:\n";
    print  join( ', ', @left_facts[ 1 .. $TARGET ] ), "\n";
}

###############################################################################
