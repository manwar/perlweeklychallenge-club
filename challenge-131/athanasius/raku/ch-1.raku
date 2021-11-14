use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 131
=========================

TASK #1
-------
*Consecutive Arrays*

Submitted by: Mark Anderson

You are given a sorted list of unique positive integers.

Write a script to return list of arrays where the arrays are consecutive
integers.

Example 1:

 Input:  (1, 2, 3, 6, 7, 8, 9)
 Output: ([1, 2, 3], [6, 7, 8, 9])

Example 2:

 Input:  (11, 12, 14, 17, 18, 19)
 Output: ([11, 12], [14], [17, 18, 19])

Example 3:

 Input:  (2, 4, 6, 8)
 Output: ([2], [4], [6], [8])

Example 4:

 Input:  (1, 2, 3, 4, 5)
 Output: ([1, 2, 3, 4, 5])

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
The input must be a list of unsigned integers. Any duplicates will be silently
removed, and the list will be sorted in increasing numerical order, before it
is processed.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 131, Task #1: Consecutive Arrays (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@list where { .all ~~ UInt:D }              #= A list of unsigned integers
)
#==============================================================================
{
    my UInt @sorted = @list.unique.sort;

    "Input:  (%s)\n".printf: @sorted.join: ', ';

    my Array[UInt] @consec = get-consecutive-arrays( @sorted );

    "Output: (%s)\n".printf:
        @consec.map( { '[' ~ .join( ', ' ) ~ ']' } ).join: ', ';
}

#------------------------------------------------------------------------------
sub get-consecutive-arrays
(
    Array:D[UInt:D] $sorted
--> Array:D[Array:D[UInt:D]]
)
#------------------------------------------------------------------------------
{
    my Array[UInt] @consec = Array[Array[UInt]].new;
    my UInt        @range;
    my UInt        $last;

    for @$sorted -> UInt $value
    {
        if !$last.defined || $last == $value - 1
        {
            @range.push: $value;
        }
        else
        {
            @consec.push: @range.clone;      # Save a copy of the current range
            @range = $value;                 # Begin the next range
        }

        $last = $value;
    }

    @consec.push: @range;

    return @consec;
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
