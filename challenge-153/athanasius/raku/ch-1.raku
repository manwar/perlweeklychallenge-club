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

Algorithm
---------
On each iteration of the main loop, the next factorial is computed, then it is
added to the cumulative sum to give the next left factorial.

=end comment
#==============================================================================

my UInt constant $TARGET = 10;

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
    my UInt @left-facts = 1;            # !1 = 0! = 1
    my UInt $factorial  = 1;
    my UInt $cum-sum    = 1;

    for 1 .. $TARGET - 1 -> UInt $n     # Compute !2 to !$TARGET
    {
        $factorial *= $n;
        $cum-sum   += $factorial;

        @left-facts.push: $cum-sum;
    }

    "The left factorials of 1 to $TARGET:".put;
    "%s\n".printf: @left-facts.join: ', ';
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
