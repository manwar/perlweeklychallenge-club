use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 080
=========================

Task #1
-------
*Smallest Positive Number Bits*

Submitted by: Mohammad S Anwar

You are given unsorted list of integers @N.

Write a script to find out the smallest positive number missing.

Example 1:

 Input: @N = (5, 2, -2, 0)
 Output: 1

Example 2:

 Input: @N = (1, 8, -1)
 Output: 2

Example 3:

 Input: @N = (2, 0, -1)
 Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 080, Task #1: Smallest Positive Number Bits (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@N where { .all ~~ Int:D }                 #= An unsorted list of integers
)
##=============================================================================
{
    "Input: @N = (%s)\n".printf: @N.join: ', ';

    my Set[Int] $N = Set[Int].new: @N.map: { .Int };    # Make a dictionary of
                                                        #   the listed integers

    my UInt $num = 1;                                   # Find the lowest int >
          ++$num while $num ∈ $N;                       #   0 not in the list

    "Output: $num".put;
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
