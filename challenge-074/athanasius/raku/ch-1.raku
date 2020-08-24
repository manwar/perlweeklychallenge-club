use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 074
=========================

Task #1
-------
*Majority Element*

Submitted by: Mohammad S Anwar

You are given an array of integers of size _$N_.

Write a script to find the majority element. If none found then print -1.

    Majority element in the list is the one that appears more than
    floor(size_of_list/2).

Example 1

Input: @A = (1, 2, 2, 3, 2, 4, 2)
Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).

Example 2

Input: @A = (1, 3, 1, 2, 4, 5)
Output: -1 as none of the elements appears more than floor(6/2).

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 074, Task #1: Majority Element (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    *@A where { @A.elems > 0 && @A.all ~~ Int:D }  #= Non-empty integer sequence
)
#===============================================================================
{
    my UInt $N       = @A.elems;
    my UInt $mean-fl = floor($N / 2);
    my Int  $output  = -1;
    my UInt %count;

    ++%count{$_} for @A;

    if (my UInt $max = %count.values.max) > $mean-fl
    {
        my %rev = %count.invert;
        $output = %rev{$max}.Int;
    }

    "Input:  \@A = (%s)\nOutput: %d\n".printf: @A.join(', '), $output;
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
