use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 197
=========================

TASK #1
-------
*Move Zero*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to move all zero, if exists, to the end while maintaining the
relative order of non-zero elements.

Example 1

  Input:  @list = (1, 0, 3, 0, 0, 5)
  Output: (1, 3, 5, 0, 0, 0)

Example 2

  Input: @list = (1, 6, 4)
  Output: (1, 6, 4)

Example 3

  Input: @list = (0, 1, 0, 2, 0)
  Output: (1, 2, 0, 0, 0)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

Algorithm
---------
1. Traverse the input list, counting zero values but copying non-zero values to
   the output list.
2. Append the number of zero values encountered in the input list to the end of
   the output list.
   -- The list repetition operator 'xx' "returns a Sequence of $a [LHS] repeat-
      ed and evaluated $b [RHS] times" (https://docs.raku.org/routine/xx).

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 197, Task #1: Move Zero (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@list where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf:            @list  .join: ', ';

    "Output:         (%s)\n" .printf: move-zero( @list ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub move-zero( List:D[Int:D] $list --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Int  @moved;
    my UInt $count = 0;

    for @$list -> Int $n
    {
        if $n == 0
        {
            ++$count;
        }
        else
        {
            @moved.push: $n;
        }
    }

    @moved.push: |(0 xx $count);

    return @moved;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
                $line.split: / \| /, $TEST-FIELDS;

        $input    ~~ s/ ^ \s* (.+?) \s* $ /$0/;               # Trim whitespace
        $expected ~~ s/ ^ \s* (.+?) \s* $ /$0/;
        $expected ~~ s:g/ \s+ / /;

        my Int @list = $input.split( / \, \s* / ).map: { .Int };

        my Str $got  = move-zero( @list ).join: ', ';

        is $got, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1| 1, 0,  3,  0, 0, 5    | 1,  3,  5,  0, 0, 0
        Example 2| 1, 6,  4              | 1,  6,  4
        Example 3| 0, 1,  0,  2, 0       | 1,  2,  0,  0, 0
        Negatives|-1, 0, -2, -3, 0, 0, -4|-1, -2, -3, -4, 0, 0, 0
        END
}

###############################################################################
