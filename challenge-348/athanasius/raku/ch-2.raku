use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 348
=========================

TASK #2
-------
*Convert Time*

Submitted by: Mohammad Sajid Anwar

You are given two strings, $source and $target, containing time in 24-hour time
form.

Write a script to convert the source into target by performing one of the
following operations:

  1. Add  1 minute
  2. Add  5 minutes
  3. Add 15 minutes
  4. Add 60 minutes

Find the total operations needed to get to the target.

Example 1

  Input: $source = "02:30"
         $target = "02:45"
  Output: 1

  Just one operation i.e. "Add 15 minutes".

Example 2

  Input: $source = "11:55"
         $target = "12:15"
  Output: 2

  Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

Example 3

  Input: $source = "09:00"
         $target = "13:00"
  Output: 4

  Four operations of "Add 60 minutes".

Example 4

  Input: $source = "23:45"
         $target = "00:30"
  Output: 3

  Three operations of "Add 15 minutes".

Example 5

  Input: $source = "14:20"
         $target = "15:25"
  Output: 2

  Two operations, one "Add 60 minutes" and one "Add 5 minutes"

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
2. A source time and a target time, both in 24-hour format, are entered on the
   command-line.

=end comment
#===============================================================================

use Test;

subset Time of Str where { / ^ (\d\d) \: (\d\d) $ / && 0 <= $0 < 24
                                                    && 0 <= $1 < 60 };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 348, Task #2: Convert Time (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Time:D $source,               #= Source time in 24-hour format
    Time:D $target                #= Target time in 24-hour format
)
#===============================================================================
{
    qq[Input:  \$source = "$source"].put;
    qq[        \$target = "$target"].put;

    my UInt $operations = convert-time( $source, $target );

    "Output: $operations".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub convert-time( Time:D $source, Time:D $target --> UInt:D )
#-------------------------------------------------------------------------------
{
    $source ~~ / ^ (\d\d) \: (\d\d) $ /;

    my UInt $start = ($0 * 60) + $1;

    $target ~~ / ^ (\d\d) \: (\d\d) $ /;

    my UInt $end   = ($0 * 60) + $1;
    my Int  $diff  =  $end - $start;
            $diff += (60 * 24) if $diff < 0;
    my UInt $ops   =  0;

    for 60, 15, 5, 1 -> UInt $n
    {
        $ops  += $diff div $n;
        $diff %= $n;
    }

    $diff == 0 or die 'Logic error';

    return $ops;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $source, $target, $expected) = $line.split: / \| /;

        for     $test-name, $source, $target, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $operations = convert-time( $source, $target );

        is $operations, $expected.Int, $test-name;
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
        Example 1   |02:30|02:45| 1
        Example 2   |11:55|12:15| 2
        Example 3   |09:00|13:00| 4
        Example 4   |23:45|00:30| 3
        Example 5   |14:20|15:25| 2
        Same time   |09:17|09:17| 0
        One minute  |17:36|17:37| 1
        Almost 1 day|17:36|17:35|32
        END
}

################################################################################
