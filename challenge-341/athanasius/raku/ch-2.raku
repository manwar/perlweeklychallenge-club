use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 341
=========================

TASK #2
-------
*Reverse Prefix*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character in the given string, $char.

Write a script to reverse the prefix upto the first occurrence of the given
$char in the given string $str and return the new string.

Example 1

  Input: $str = "programming", $char = "g"
  Output: "gorpramming"

  Reverse of prefix "prog" is "gorp".

Example 2

  Input: $str = "hello", $char = "h"
  Output: "hello"

Example 3

  Input: $str = "abcdefghij", $char = "h"
  Output: "hgfedcbaij"

Example 4

  Input: $str = "reverse", $char = "s"
  Output: "srevere"

Example 5

  Input: $str = "perl", $char = "r"
  Output: "repl"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Characters are case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty string is entered on the command-line, followed by a single
   character in the given string.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 341, Task #2: Reverse Prefix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty string

    Str:D $str  where { .chars >  0 },

    #| A character in the given string

    Str:D $char where { .chars == 1 && $str ~~ / $char / }
)
#===============================================================================
{
    qq[Input: \$str = "$str", \$char = "$char"].put;

    my Str $rev = reverse-prefix( $str, $char );

    qq[Output:       "$rev"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-prefix
(
    Str:D $str  where { .chars >  0 },
    Str:D $char where { .chars == 1 && $str ~~ / $char / }
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my Str ($first, $last) = $str.split: $char, 2;

    return $char ~ $first.flip ~ $last;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $char, $expected) = $line.split: / \| /;

        for     $test-name, $str, $char, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $rev = reverse-prefix( $str, $char );

        is $rev, $expected, $test-name;
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
        Example 1|programming|g|gorpramming
        Example 2|hello      |h|hello
        Example 3|abcdefghij |h|hgfedcbaij
        Example 4|reverse    |s|srevere
        Example 5|perl       |r|repl
        END
}

################################################################################
