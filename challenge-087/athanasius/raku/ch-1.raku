use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 087
=========================

Task #1
-------
*Longest Consecutive Sequence*

Submitted by: Mohammad S Anwar

You are given an unsorted array of integers @N.

Write a script to find the longest consecutive sequence. Print 0 if none
sequence found.

Example 1:

 Input: @N = (100, 4, 50, 3, 2)
 Output: (2, 3, 4)

Example 2:

 Input: @N = (20, 30, 10, 40, 50)
 Output: 0

Example 3:

 Input: @N = (20, 19, 9, 11, 10)
 Output: (9, 10, 11)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

From the Examples, it appears that a "sequence" is an ordered set of TWO or
more integers in which adjacent numbers differ by exactly 1. It is assumed that
any duplicates in the input array are irrelevant to the solution and may be
ignored.

The algorithm used:
    1. Sort the input array in increasing numerical order.
    2. Create a list of sequences (an AoA) as follows: put the first element
       into a new sequence, and then, for each succeeding element, either:
       a. ignore it because it is equal to the previous element; or
       b. add it to the current sequence because it is exactly one greater than
          the last element added to that sequence; or
       c. use it to start a new sequence.
    3. Find the longest sequence. If its length is 2 or more, output it, other-
       wise output "0".

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 087, Task #1: Longest Consecutive Sequence (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| A non-empty, unsorted array of integers

    *@N where { @N.elems > 0 && .all ~~ Int:D }
)
#==============================================================================
{
    my Int @n = @N.map: { .Int };

    "Input:  @N = (%s)\n".printf: @n.join: ', ';

    my Array[Int] @sequences   = find-sequences(@n);
    my Array[Int] $longest-seq = get-longest-sequence(@sequences);

    if $longest-seq.elems <= 1
    {
        'Output: 0'.put;
    }
    else
    {
        "Output: (%s)\n".printf: $longest-seq.join: ', ';
    }
}

#------------------------------------------------------------------------------
sub find-sequences
(
    Int:D @N                    #= The input array of unsorted integers
--> Array:D[Array:D[Int:D]]     #= An array of sequences of successive integers
)
#------------------------------------------------------------------------------
{
    @N = @N.sort;

    my Int  $prev  = @N.shift;
    my UInt $index = 0;

    my Array[Int] @seqs;
    @seqs[$index]  = Array[Int].new($prev);

    for @N -> Int $current
    {
        next if $current == $prev;

        if $current == $prev + 1
        {
            @seqs[$index].push: $current;
        }
        else
        {
            @seqs[++$index] = Array[Int].new($current);
        }

        $prev = $current;
    }

    return @seqs;
}

#------------------------------------------------------------------------------
sub get-longest-sequence
(
    Array:D[Array:D[Int:D]] @seqs        #= An array of sequences of successive
                                         #=   integers
--> Array:D[Int:D]                       #= The longest sequence
)
#------------------------------------------------------------------------------
{
    my UInt $max-count = 0;
    my Int  @max-seq;

    for @seqs -> Int @seq
    {
        my UInt $count = @seq.elems;

        if $count > $max-count
        {
            $max-count = $count;
            @max-seq   = @seq;
        }
    }

    return @max-seq;
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
