use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 360
=========================

TASK #1
-------
*Text Justifier*

Submitted by: Mohammad Sajid Anwar

You are given a string and a width.

Write a script to return the string that centers the text within that width
using asterisks * as padding.

Example 1

  Input: $str = "Hi", $width = 5
  Output: "*Hi**"

  Text length = 2, Width = 5
  Need 3 padding characters total
  Left padding: 1 star, Right padding: 2 stars

Example 2

  Input: $str = "Code", $width = 10
  Output: "***Code***"

  Text length = 4, Width = 10
  Need 6 padding characters total
  Left padding: 3 stars, Right padding: 3 stars

Example 3

  Input: $str = "Hello", $width = 9
  Output: "**Hello**"

  Text length = 5, Width = 9
  Need 4 padding characters total
  Left padding: 2 stars, Right padding: 2 stars

Example 4

  Input: $str = "Perl", $width = 4
  Output: "Perl"

  No padding needed

Example 5

  Input: $str = "A", $width = 7
  Output: "***A***"

  Text length = 1, Width = 7
  Need 6 padding characters total
  Left padding: 3 stars, Right padding: 3 stars

Example 6

  Input: $str = "", $width = 5
  Output: "*****"

  Text length = 0, Width = 5
  Entire output is padding

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. An input width less that the length of the input string is to be treated as
   an error.
2. If the string cannot be exactly justified within the given width, its dis-
   tance from the left of the justified string shall be one character less than
   its distance from the right (see Example 1).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string to be justified is entered on the command-line, followed by the
   width of the field within which the string is to be justified. The width must
   be at least as great as the length of the string. 

=end comment
#===============================================================================

use Test;

my constant PADDING = '*';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 360, Task #1: Text Justifier (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| String to be justified

    Str:D  $str,

    #| Width (at least the length of <str>)

    UInt:D $width where * >= $str.chars
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$width = $width].put;

    my Str $justified = justify-text( $str, $width );

    qq[Output: "$justified"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub justify-text
(
    Str:D  $str,
    UInt:D $width where * >= $str.chars
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my UInt $diff   = $width - $str.chars;
    my Str  $prefix = PADDING x ($diff div 2);
    my Str  $suffix = PADDING x ($diff - $prefix.chars);

    return  $prefix ~ $str ~ $suffix;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $width, $expected) = $line.split: / \| /;

        for     $test-name,       $width, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $justified = justify-text( $str, $width.Int );

        is $justified, $expected, $test-name;
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
        Example 1|Hi|   5|*Hi**
        Example 2|Code|10|***Code***
        Example 3|Hello|9|**Hello**
        Example 4|Perl| 4|Perl
        Example 5|A|    7|***A***
        Example 6||     5|*****
        END
}

################################################################################
