use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 276
=========================

TASK #2
-------
*Maximum Frequency*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the total number of elements in the given array which
have the highest frequency.

Example 1

  Input: @ints = (1, 2, 2, 4, 1, 5)
  Output: 4

  The maximum frequency is 2.
  The elements 1 and 2 has the maximum frequency.

Example 2

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 5

  The maximum frequency is 1.
  The elements 1, 2, 3, 4 and 5 has the maximum frequency.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
"Positive integers" are greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input integers are entered as a non-empty list at the end of the command-
   line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 276, Task #2: Maximum Frequency (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Bool:D :$verbose = False,                     #= Explain the output?

    *@ints where { .elems > 0 && .all ~~ Pos:D }  #= A list of positive integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my %max = max-freq( @ints );

    "Output: %d\n".printf: %max< count >;

    if $verbose
    {
        "\nMaximum frequency: %d\n".printf: %max< freq >;

        "Element%s with the maximum frequency: %s\n".printf:
            %max< elems >.elems == 1 ?? '' !! 's', %max< elems >.join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub max-freq( List:D[Pos:D] $ints --> Hash:D )
#-------------------------------------------------------------------------------
{
    my UInt %freq{Pos};
          ++%freq{ $_ } for @$ints;

    my %max = freq => %freq<>:v.max, count => 0;

    my UInt %elem{Pos};

    for @$ints
    {
        if %freq{ $_ } == %max< freq >
        {
            ++%elem{ $_ };
            ++%max< count >;
        }
    }

    %max< elems > = Array[Pos].new: %elem<>:k.sort;

    return %max;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints, $exp-max-freq, $elems, $exp-count) =
                $line.split: / \| /;

        for     $test-name, $ints, $exp-max-freq, $elems, $exp-count
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos @ints      = $ints\.split( / \s+ /, :skip-empty ).map: { .Int };
        my Pos @exp-elems = $elems.split( / \s+ /, :skip-empty ).map: { .Int };
        my     %max       = max-freq( @ints );

        is        %max< freq  >, $exp-max-freq.Int, $test-name;
        is-deeply %max< elems >, @exp-elems,        $test-name;
        is        %max< count >, $exp-count.Int,    $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1  |1 2 2 4 1 5|2|1 2      |4
        Example 2  |1 2 3 4 5  |1|1 2 3 4 5|5
        Single elem|7 3 7 5 7 9|3|7        |3
        END
}

################################################################################
