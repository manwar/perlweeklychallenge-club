use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 078
=========================

Task #1
-------
*Leader Element*

Submitted by: Mohammad S Anwar

You are given an array @A containing distinct integers.

Write a script to find all leader elements in the array @A. Print (0) if none
found.

        An element is leader if it is greater than all the elements to its
        right side.

Example 1:

 Input: @A = (9, 10, 7, 5, 6, 1)
 Output: (10, 7, 6, 1)

Example 2:

 Input: @A = (3, 4, 5)
 Output: (5)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----

If @A contains a single element only, that element is (trivially) "greater than
all the elements to its right side." The array @A is specified to contain
"distinct integers." Since 0 is an integer, a correct solution could be:

 Input: @A = (0)
 Output: (0)

But an empty array is still an array, and therefore a legal input. Further, an
empty array is the only input for which no leader element can be found. Since
an output of (0) [as specified in the Task] would be identical to the output
for @A = (0), as explained above, I have departed from the specification and
output:

 Input: @A = ()
 Output: ()

in this case.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 078, Task #1: Leader Element (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    #| A list of distinct integers

    *@A where { .all ~~ Int:D && .repeated.elems == 0 }
)
##=============================================================================
{
    "Input: \@A = (%s)\n".printf: @A.join: ', ';

    my Int @leaders;

    OUTER-FOR: for 0 .. @A.end -> UInt $i
    {
        for $i + 1 .. @A.end -> UInt $j
        {
            next OUTER-FOR unless @A[$i] > @A[$j];
        }

        @leaders.push: @A[$i];
    }

    "Output:     (%s)\n".printf: @leaders.join: ', ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
