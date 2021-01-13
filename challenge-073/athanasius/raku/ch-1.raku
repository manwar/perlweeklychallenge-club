use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 073
=========================

Task #1
-------
*Min Sliding Window*

Submitted by: Mohammad S Anwar

You are given an array of integers @A and sliding window size $S.

Write a script to create an array of min from each sliding window.

Example

Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
Output: (0, 0, 0, 2, 3, 3, 4, 4)

[(1 5 0) 2 9 3 7 6 4 8] = Min (0)
[1 (5 0 2) 9 3 7 6 4 8] = Min (0)
[1 5 (0 2 9) 3 7 6 4 8] = Min (0)
[1 5 0 (2 9 3) 7 6 4 8] = Min (2)
[1 5 0 2 (9 3 7) 6 4 8] = Min (3)
[1 5 0 2 9 (3 7 6) 4 8] = Min (3)
[1 5 0 2 9 3 (7 6 4) 8] = Min (4)
[1 5 0 2 9 3 7 (6 4 8)] = Min (4)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

subset Natural of UInt where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 073, Task #1: Min Sliding Window (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    Natural:D :$S,                #= Sliding window size: 0 < S <= integers in A

    *@A where { @A.elems >  0  &&            #= Sequence of one or more integers
                @A.elems >= $S &&
                @A.all   ~~ Int:D }
)
#===============================================================================
{
    "Input: @A = (%s) and \$S = %d\n".printf: @A.join(', '), $S;

    my Int @minima;
           @minima.push: min @A[$_ .. $_ + $S - 1] for 0 .. @A.elems - $S;

    "Output: (%s)\n".printf: @minima.join: ', ';
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
