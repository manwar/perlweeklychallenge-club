use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 136
=========================

TASK #2
-------
*Fibonacci Sequence*

Submitted by: Mohammad S Anwar

You are given a positive number $n.

Write a script to find how many different sequences you can create using
Fibonacci numbers where the sum of unique numbers in each sequence are the same
as the given number.

    Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89, …

Example 1

  Input:  $n = 16
  Output: 4

  Reason: There are 4 possible sequences that can be created using Fibonacci
  numbers i.e. (3 + 13), (1 + 2 + 13), (3 + 5 + 8) and (1 + 2 + 5 + 8).

Example 2

  Input:  $n = 9
  Output: 2

  Reason: There are 2 possible sequences that can be created using Fibonacci
  numbers i.e. (1 + 3 + 5) and (1 + 8).

Example 3

  Input:  $n = 15
  Output: 2

  Reason: There are 2 possible sequences that can be created using Fibonacci
  numbers i.e. (2 + 5 + 8) and (2 + 13).

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Include the flag "--verbose" on the command line to display an explanation of
the output.

Algorithm
---------
1. Find the set F of Fibonacci numbers less than or equal to $n
2. Calculate the power set P(F) of all subsets of F
3. For each subset S in P(F), sum the elements of S and add S to the solution
   set iff the sum equals $n

Note: This algorithm works well for smaller values of $n, but will not scale
well for larger values.

Implementation
--------------
Calculation of the power set is performed by Raku's inbuilt combinations()
method.

=end comment
#==============================================================================

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 136, Task #2: Fibonacci Sequence (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Pos:D   $n,                           #= An integer > 0
    Bool:D :$verbose = False              #= Explain the output?
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    my Array[Pos] @seqs  = find-fib-seqs( $n );
    my UInt       $count = @seqs.elems;

    "Output: $count".put;

    if $verbose
    {
        if    $count == 0
        {
            ("\nReason: There are no possible sequences summing to $n" ~
             "\n\tthat can be created using unique Fibonacci numbers").put;
        }
        elsif $count == 1
        {
            ("\nReason: There is one possible sequence summing to $n"  ~
             "\n\tthat can be created using unique Fibonacci numbers:" ~
             "\n\t(%s)\n").printf: @seqs[ 0 ].join: ' + ';
        }
        else
        {
            ("\nReason: There are $count possible sequences summing to $n" ~
             "\n\tthat can be created using unique Fibonacci numbers:").put;

             "\t(%s)\n".printf: $_.join: ' + ' for @seqs;
        }
    }
}

#------------------------------------------------------------------------------
sub find-fib-seqs( Pos:D $n --> Array:D[Array:D[Pos:D]] )
#------------------------------------------------------------------------------
{
    my Array[Pos] @seqs;
    my Array[Pos] $fibs = get-fib-nums( $n );

    for $fibs.combinations: 1 .. * -> List $c
    {
        my UInt $sum = [+] @$c;              # Sum using reduction metaoperator

        @seqs.push: Array[Pos].new: @$c if $sum == $n;
    }

    return @seqs;
}

#------------------------------------------------------------------------------
sub get-fib-nums( Pos:D $n --> Array:D[Pos:D] )
#------------------------------------------------------------------------------
{
    my Pos  @fibs   =  1;
    my Pos ($x, $y) = (1, 1);

    while @fibs[ *-1 ] < $n
    {
        my Pos $z = $x + $y;

        @fibs.push: $z;

        $x = $y;
        $y = $z;
    }

    @fibs.pop if @fibs[ *-1 ] > $n;

    return @fibs;
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
