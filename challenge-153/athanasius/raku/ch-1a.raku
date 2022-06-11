use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
This alternative solution to Task 1 is provided only for interest; it is *much*
less efficient than the solution provided in "ch-1.raku".

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

=end comment
#==============================================================================

my UInt constant $TARGET     = 10;
my UInt constant $SIEVE-SIZE = 410_000;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 153, Task #1: Left Factorials (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @sieve = 0 .. $SIEVE-SIZE;

    for 2 .. $TARGET - 1 -> UInt $step
    {
        # Find the index of a(step)

        my UInt $i     = 0;
        my UInt $count = $step;

        while $count > 0
        {
            --$count if @sieve[ ++$i ].defined;
        }

        # Beginning at the first defined number beyond a(step): for each
        # consecutive set of step defined numbers, remove all but the last

        while $i < @sieve.end
        {
            $count = $step;

            while $count > 0 && $i < @sieve.end
            {
                if @sieve[ ++$i ].defined
                {
                    @sieve[ $i ] = Nil unless --$count == 0;
                }
            }
        }
    }

    my UInt @left-facts = @sieve.grep: { .defined };

    "The left factorials of 1 to $TARGET:".put;
    "%s\n".printf: @left-facts[ 1 .. $TARGET ].join: ', ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
