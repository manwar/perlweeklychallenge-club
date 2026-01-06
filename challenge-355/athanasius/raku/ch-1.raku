use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 355
=========================

TASK #1
-------
*Thousand Separator*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.

Example 1

  Input: $int = 123
  Output: "123"

Example 2

  Input: $int = 1234
  Output: "1,234"

Example 3

  Input: $int = 1000000
  Output: "1,000,000"

Example 4

  Input: $int = 1
  Output: "1"

Example 5

  Input: $int = 12345
  Output: "12,345"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive integer" is an unsigned integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer is entered on the command-line.

=end comment
#===============================================================================

use Test;

my UInt constant DIGIT-COUNT = 3;
my Str  constant SEPARATOR   = ',';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 355, Task #1: Thousand Separator (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $int                      #= A positive integer
)
#===============================================================================
{
    "Input:  \$int = $int".put;

    my Str $str = add-separators( $int );

    qq[Output: "$str"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub add-separators( UInt:D $int --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str  @digits = $int.split: '', :skip-empty;
    my UInt $count  = 0;
    my Str  @chars;

    while @digits
    {
        @chars.unshift: @digits.pop;

        if ++$count == DIGIT-COUNT
        {
            @chars.unshift: SEPARATOR;
            $count = 0;
        }
    }

    @chars.shift if @chars[0] eq SEPARATOR;

    return @chars.join;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $expected) = $line.split: / \| /;

        for     $test-name, $int-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $str = add-separators( $int-str.Int );

        is $str, $expected, $test-name;
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
        Example 1|      123|        123
        Example 2|     1234|      1,234
        Example 3|  1000000|  1,000,000
        Example 4|        1|          1
        Example 5|    12345|     12,345
        3 x 3    |987654321|987,654,321
        END
}

################################################################################
