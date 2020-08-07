use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 067
=========================

Task #1
-------
*Number Combinations*

*Submitted by:* Mohammad S Anwar

You are given two integers $m and $n. Write a script [to] print all possible
combinations of $n numbers from the list 1 2 3 … $m.

Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is
not.

*Example:*

Input: $m = 5, $n = 2

Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    UInt:D $m where { $m > 0 },     #= Integer > 0: maximum of numbers to select
    UInt:D $n where { $n > 0 },     #= Integer > 0: size of each n-combination
)
#===============================================================================
{
    "Challenge 067, Task #1: Number Combinations (Raku)\n".put;

    'Note: No combinations are possible, because n > m'.note if $n > $m;

    my Str @combs;

    for (1 .. $m).combinations: $n -> List $comb
    {
        @combs.push: '[%s]'.sprintf: $comb.join: ',';
    }

    my UInt $count = @combs.elems;

    "There %s %d unique %d-combination%s of the integers 1 to %d:\n[ %s ]\n".
        printf: $count == 1 ?? 'is' !! 'are', $count, $n,
                $count == 1 ?? ''   !! 's',   $m,     @combs.join: ', ';
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
