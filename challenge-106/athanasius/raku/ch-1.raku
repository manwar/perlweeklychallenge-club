use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 106
=========================

Task #1
-------
*Maximum Gap*

Submitted by: Mohammad S Anwar

You are given an array of integers @N.

Write a script to display the maximum difference between two successive
elements once the array is sorted.

If the array contains only 1 element then display 0.

Example

 Input: @N = (2, 9, 3, 5)
 Output: 4

 Input: @N = (1, 3, 8, 2, 0)
 Output: 5

 Input: @N = (5)
 Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Straightforward: Sort the array in ascending order, then iterate through all
pairs of adjacent elements and record the largest gap. Default to zero if there
is only one element in the array.

Note on Duplicates
------------------
For large arrays containing many duplicate elements, it might be possible to
obtain a small speed-up by removing duplicates from the sorted array before
testing adjacent elements. The (optional) flag --unique is provided for this
purpose. It defaults to False, since for small arrays the speed-up is likely
more than outweighed by the overhead of duplicate removal.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 106, Task #1: Maximum Gap (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Bool:D :$unique = False,                    #= (Optional) remove duplicates
           *@N where { @N.elems > 0 &&          #= A non-empty, unsorted list
                       .all ~~ Int:D }          #=   of integers
)
#==============================================================================
{
    my Int  @array = @N.map: { .Int };                 # Change IntStrs to Ints

    "Input:  \@N = (%s)\n".printf: @array.join: ', ';

    my Int  @sorted  = @array.sort;                    # Sort ascending
            @sorted  = @sorted.squish if $unique;      # Optionally remove dups
    my UInt $max-gap = 0;

    # Test every difference between successive elements in the sorted array

    for 1 .. @sorted.end -> UInt $i
    {
        my UInt $diff = @sorted[ $i ] - @sorted[ $i - 1 ];

        $max-gap = $diff if $diff > $max-gap;
    }

    "Output: $max-gap".put;
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
