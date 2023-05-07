use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 215
=========================

TASK #2
-------
*Number Placement*

Submitted by: Mohammad S Anwar

You are given a list of numbers having just 0 and 1. You are also given place-
ment count (>=1).

Write a script to find out if it is possible to replace 0 with 1 in the given
list. The only condition is that you can only replace when there is no 1 on
either side. Print 1 if it is possible otherwise 0.

Example 1:

  Input: @numbers = (1,0,0,0,1), $count = 1
  Output: 1

  You are asked to replace only one 0 as given count is 1.
  We can easily replace middle 0 in the list i.e. (1,0,1,0,1).

Example 2:

  Input: @numbers = (1,0,0,0,1), $count = 2
  Output: 0

  You are asked to replace two 0's as given count is 2.
  It is impossible to replace two 0's.

Example 3:

  Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
  Output: 1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to True, an output of 1 is followed by a list containing
   the required replacements.

Assumption
----------
The task description says:

    "...replace 0 with 1 in the given list.... you can only replace when there
     is no 1 on either side."

I assume this condition (re-)applies *as each replacement is made*. For example,
in the list:

    (1,0,0,0,0,1)
     a b c d e f

the middle two zeros (c and d) both satisfy the condition at the outset; but
once a single replacement is made, e.g. replace c: (1,0,1,0,0,1), the condition
no longer holds for d, so no further replacement is possible.

=end comment
#===============================================================================

my Bool constant $VERBOSE = True;

subset Pos of Int where * > 0;
subset Bit of Int where 0|1;

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 215, Task #2: Number Placement (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $numbers where / ^ <[ 0 1 ]>+ $ /,    #= Non-empty string of 0s and 1s
    Pos:D $count                                #= Placement count (>= 1)
)
#===============================================================================
{
    my Bit @numbers = $numbers.split( '', :skip-empty ).map: { .Int };

    "Input:  \@numbers = (%s), \$count = %d\n".printf:
        @numbers.join( ',' ), $count;

    my Bit @new-list = make-replacements( @numbers, $count );

    "Output: %d\n".printf: @new-list.elems ?? 1 !! 0;

    if ($VERBOSE && @new-list.elems)
    {
        printf "\nReplacement list:  (%s)\n", join ',', @new-list;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub make-replacements( Array:D[Bit:D] $numbers, Pos:D $count --> List:D[Bit:D] )
#-------------------------------------------------------------------------------
{
    my UInt $my-count   =  $count;
    my Bit  @my-numbers = |$numbers;

    for 0 .. $numbers.end -> UInt $i
    {
        if ($i == 0            || @my-numbers[ $i - 1 ] == 0) &&
                                  @my-numbers[ $i     ] == 0  &&
           ($i == $numbers.end || @my-numbers[ $i + 1 ] == 0)
        {
            @my-numbers[ $i ] = 1;

            return @my-numbers if --$my-count == 0;
        }
    }

    return ();      # Empty list
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $numbers, $count, $expected) = $line.split: / \| /;

        s/ \s+ $ // for $test-name, $numbers, $count;          # Trim whitespace

        my Bit @numbers  = $numbers.split( '', :skip-empty ).map: { .Int };
        my Bit @new-list = make-replacements( @numbers, $count.Int );

        is @new-list.elems ?? 1 !! 0, $expected.Int, $test-name;
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
        Example 1    |10001        |1|1
        Example 2    |10001        |2|0
        Example 3    |100000001    |3|1
        Beginning    |0010000000010|4|1
        Ending       |0100000000100|4|1
        Start and end|001100       |2|1
        One too many |0100000000100|5|0
        END
}

################################################################################
