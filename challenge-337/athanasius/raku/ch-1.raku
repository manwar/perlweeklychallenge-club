use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 337
=========================

TASK #1
-------
*Smaller Than Current*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers, @num1.

Write a script to return an array, @num2, where $num2[i] is the count of all
numbers less than or equal to $num1[i].

Example 1

  Input: @num1 = (6, 5, 4, 8)
  Output: (2, 1, 0, 3)

  index 0: numbers <= 6 are 5, 4    => 2
  index 1: numbers <= 5 are 4       => 1
  index 2: numbers <= 4, none       => 0
  index 3: numbers <= 8 are 6, 5, 4 => 3

Example 2

  Input: @num1 = (7, 7, 7, 7)
  Output: (3, 3, 3, 3)

Example 3

  Input: @num1 = (5, 4, 3, 2, 1)
  Output: (4, 3, 2, 1, 0)

Example 4

  Input: @num1 = (-1, 0, 3, -2, 1)
  Output: (1, 2, 4, 0, 3)

Example 5

  Input: @num1 = (0, 1, 1, 2, 0)
  Output: (1, 3, 3, 4, 1)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input numbers are integers.
2. The Task should read:

     Write a script to return an array, @num2, where $num2[i] is the count of
     all *other* numbers less than or equal to $num1[i].

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 337, Task #1: Smaller Than Current (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@num1 where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input: \@num1 = (%s)\n".printf: @num1.join: ', ';

    my UInt @num2 = smaller-than-current( @num1 );

    "Output: (%s)\n"\       .printf: @num2.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub smaller-than-current( List:D[Int:D] $num1 --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt %freq{Int};
          ++%freq{$_} for @$num1;

    my Int  @keys = %freq.keys.sort;
    my UInt $sum  = 0;
    my UInt %cum-freq{Int};

    for @keys -> Int $key
    {
        $sum += %freq{$key};
        %cum-freq{$key} = $sum;
    }

    my UInt @num2;

    for @$num1 -> Int $num
    {
        @num2.push: %cum-freq{$num} - 1;
    }

    return @num2;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num1-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $num1-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @num1 = $num1-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @num2 = smaller-than-current( @num1 );
        my UInt @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @num2, @expd, $test-name;
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
        Example 1| 6 5 4  8  |2 1 0 3
        Example 2| 7 7 7  7  |3 3 3 3
        Example 3| 5 4 3  2 1|4 3 2 1 0
        Example 4|-1 0 3 -2 1|1 2 4 0 3
        Example 5| 0 1 1  2 0|1 3 3 4 1
        END
}

################################################################################
