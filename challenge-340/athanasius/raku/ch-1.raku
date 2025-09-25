use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 340
=========================

TASK #1
-------
*Duplicate Removals*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have been
made. Repeat duplicate removals on the given string until we no longer can.

    A duplicate removal consists of choosing two adjacent and equal letters and
    removing them.

Example 1

  Input: $str = 'abbaca'
  Output: 'ca'

  Step 1: Remove 'bb' => 'aaca'
  Step 2: Remove 'aa' => 'ca'

Example 2

  Input: $str = 'azxxzy'
  Output: 'ay'

  Step 1: Remove 'xx' => 'azzy'
  Step 2: Remove 'zz' => 'ay'

Example 3

  Input: $str = 'aaaaaaaa'
  Output: ''

  Step 1: Remove 'aa' => 'aaaaaa'
  Step 2: Remove 'aa' => 'aaaa'
  Step 3: Remove 'aa' => 'aa'
  Step 4: Remove 'aa' => ''

Example 4

  Input: $str = 'aabccba'
  Output: 'a'

  Step 1: Remove 'aa' => 'bccba'
  Step 2: Remove 'cc' => 'bba'
  Step 3: Remove 'bb' => 'a'

Example 5

  Input: $str = 'abcddcba'
  Output: ''

  Step 1: Remove 'dd' => 'abccba'
  Step 2: Remove 'cc' => 'abba'
  Step 3: Remove 'bb' => 'aa'
  Step 4: Remove 'aa' => ''

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
2. A single string of lowercase English letters is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 340, Task #1: Duplicate Removals (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string of lowercase English letters

    Str:D $str where { / ^ <.lower>* $ / }
)
#===============================================================================
{
    "Input:  \$str = '$str'".put;

    my Str $no-dups = remove-duplicates( $str );

    "Output: '$no-dups'".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub remove-duplicates( Str:D $str where { / ^ <.lower>* $ / } --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $no-dups = $str;

    Nil while $no-dups ~~ s/ (.) $0 //;

    return $no-dups;
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

        my Str $no-dups = remove-duplicates( $str );

        is $no-dups, $expected, $test-name;
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
        Example 1|abbaca  |ca
        Example 2|azxxzy  |ay
        Example 3|aaaaaaaa|
        Example 4|aabccba |a
        Example 5|abcddcba|
        END
}

################################################################################
