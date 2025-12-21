use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 352
=========================

TASK #2
-------
*Binary Prefix*

Submitted by: Mohammad Sajid Anwar

You are given an array, @nums, where each element is either 0 or 1.

Define xi as the number formed by taking the first i+1 bits of @nums (from
$nums[0] to $nums[i]) and interpreting them as a binary number, with $nums[0]
being the most significant bit.

For example:

  If @nums = (1, 0, 1), then:

  x0 = 1 (binary 1)
  x1 = 2 (binary 10)
  x2 = 5 (binary 101)

  For each i, check whether xi is divisible by 5.

Write a script to return an array @answer where $answer[i] is true if
x<sub>i</sub> is divisible by 5, otherwise false.                           #/

Example 1

  Input: @nums = (0,1,1,0,0,1,0,1,1,1)
  Output: (true, false, false, false, false, true, true, false, false, false)

  Binary numbers formed (decimal values):
           0: 0
          01: 1
         011: 3
        0110: 6
       01100: 12
      011001: 25
     0110010: 50
    01100101: 101
   011001011: 203
  0110010111: 407

Example 2

  Input: @num = (1,0,1,0,1,0)
  Output: (false, false, true, true, false, false)

       1: 1
      10: 2
     101: 5
    1010: 10
   10101: 21
  101010: 42

Example 3

  Input: @num = (0,0,1,0,1)
  Output: (true, true, false, false, true)

      0: 0
     00: 0
    001: 1
   0010: 2
  00101: 5

Example 4

  Input: @num = (1,1,1,1,1)
  Output: (false, false, false, true, false)

      1: 1
     11: 3
    111: 7
   1111: 15
  11111: 31

Example 5

  Input: @num = (1,0,1,1,0,1,0,0,1,1)
  Output: (false, false, true, false, false, true, true, true, false, false)

           1: 1
          10: 2
         101: 5
        1011: 11
       10110: 22
      101101: 45
     1011010: 90
    10110100: 180
   101101001: 361
  1011010011: 723

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of binary digits is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset BinDig of UInt where * ~~ 0 | 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 352, Task #2: Binary Prefix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of binary digits

    *@nums where { .elems > 0 && .all ~~ BinDig:D }
)
#===============================================================================
{
    "Input:  \@num = (%s)\n".printf: @nums.join: ',';

    my Bool @answers = find-answers( @nums );

    "Output: (%s)\n".printf: @answers.map( { $_ ?? 'true' !! 'false' } )
                                     .join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-answers( List:D[BinDig:D] $nums --> List:D[Bool:D] )
#-------------------------------------------------------------------------------
{
    my Bool @answers;
    my Str  $bin-str = '';

    for 0 .. $nums.end -> UInt $i
    {
        $bin-str ~= $nums[$i];

        @answers.push: "0b$bin-str".Int %% 5;
    }

    return @answers;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $num-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my BinDig @nums     = $num-str.split( '', :skip-empty ).map: { .Int  };
        my Bool   @answers  = find-answers( @nums );
        my Str    @ans-str  = @answers.map: { $_        ?? 'true' !! 'false' };
        my Str    @expected = $exp-str.split( '', :skip-empty )
                                      .map: { $_ eq '1' ?? 'true' !! 'false' };

        is-deeply @ans-str, @expected, $test-name;
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
        Example 1|0110010111|1000011000
        Example 2|    101010|    001100
        Example 3|     00101|     11001
        Example 4|     11111|     00010
        Example 5|1011010011|0010011100
        END
}

################################################################################
