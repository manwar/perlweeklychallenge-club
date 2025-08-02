use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 332
=========================

TASK #2
-------
*Odd Letters*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find out if each letter in the given string appeared odd
number of times.

Example 1

  Input: $str = "weekly"
  Output: false

  w: 1 time
  e: 2 times
  k: 1 time
  l: 1 time
  y: 1 time

  The letter 'e' appeared 2 times i.e. even.

Example 2

  Input: $str = "perl"
  Output: true

Example 3

  Input: $source = "challenge"
  Output: false

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
2. A string is entered on the command-line.

Assumptions
-----------
1. Non-letter characters in the string are ignored.
2. The identification of a letter is not case-sensitive; so, e.g., 'a' and 'A'
   are considered the same letter.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 332, Task #2: Odd Letters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Bool $all-odd = all-letters-odd( $str );

    "Output: %s\n".printf: $all-odd ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub all-letters-odd( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict;
    my Str  @chars = $str.split: '', :skip-empty;

    for @chars -> Str $char
    {
        ++%dict{ $char.lc } if $char ~~ / ^ <[ A..Z a..z ]> $ /;
    }

    for %dict.values -> UInt $val
    {
        return False if $val %% 2;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $all-odd = all-letters-odd( $str ) ?? 'true' !! 'false';

        is $all-odd, $expected, $test-name;
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
        Example 1   |weekly   |false
        Example 2   |perl     |true
        Example 3   |challenge|false
        Mixed case 1|Test1    |false
        Mixed case 2|**ee4E%% |true
        END
}

################################################################################
