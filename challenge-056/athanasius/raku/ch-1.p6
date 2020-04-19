use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 056
=========================

Task #1
-------
*Diff-K*

You are given an array *@N* of positive integers (sorted) and another non
negative integer *k*.

Write a script to find if there exists 2 indices *i* and *j* such that
*A[i] - A[j] = k* and *i != j*.

It should print the pairs of indices, if any such pairs exist.

Example:

    @N = (2, 7, 9)
    $k = 2

Output : 2,1

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
    UInt:D :$K,         #=  K is a non-negative integer
           *@N,         #= @N is an array of positive integers
)
#===============================================================================
{
    "Challenge 056, Task #1: Diff-K (Raku)\n".put;

    # 1. Validate and print @N and K

    @N.elems > 0 or die 'ERROR: The array is empty';

    for @N
    {
        my UInt $entry = $_;
        $entry > 0 or die "ERROR: Invalid array entry '$_'";
    }

    @N = @N.sort;

    "\@N = (%s)\n K =  %d\n\n".printf: @N.join(', '), $K;

    # 2. Find all solutions

    my @solutions;

    for 1 .. @N.elems - 1 -> UInt $i
    {
        for 0 .. $i - 1 -> UInt $j
        {
            @solutions.push: [$i, $j] if @N[$i] - @N[$j] == $K;
        }
    }

    # 3. Output the solutions

    my UInt $solutions = @solutions.elems;

    if $solutions == 0
    {
        "No solutions found".put;
    }
    else
    {
        printf "Found %d solution%s: %s\n",
                $solutions, $solutions == 1 ?? '' !! 's',
                @solutions.map( { "($_[0], $_[1])" } ).join: ', ';
    }
}

###############################################################################
