use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 341
=========================

TASK #1
-------
*Broken Keyboard*

Submitted by: Mohammad Sajid Anwar

You are given a string containing English letters only and also you are given
broken keys.

Write a script to return the total words in the given sentence can be typed
completely.

Example 1

  Input: $str = 'Hello World', @keys = ('d')
  Output: 1

  With broken key 'd', we can only type the word 'Hello'.

Example 2

  Input: $str = 'apple banana cherry', @keys = ('a', 'e')
  Output: 0

Example 3

  Input: $str = 'Coding is fun', @keys = ()
  Output: 3

  No keys broken.

Example 4

  Input: $str = 'The Weekly Challenge', @keys = ('a','b')
  Output: 2

Example 5

  Input: $str = 'Perl and Python', @keys = ('p')
  Output: 1

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
2. A string is entered on the command-line, followed by a list of broken keys.
   The string comprises English letters and whitespace; each broken key is a
   single English letter.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 341, Task #1: Broken Keyboard (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A single string of English letters (with whitespace)

    Str:D $str  where {         / ^ <[ A..Z a..z \s ]>* $ / },

    #| A list of broken keys

         *@keys where { .all ~~ / ^ <[ A..Z a..z    ]>  $ / }
)
#===============================================================================
{
    "Input:  \$str = '$str', \@keys = (%s)\n".printf:
              @keys.map( { "'$_'" } ).join: ', ';

    my UInt $count = count-typeable-words( $str, @keys );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-typeable-words
(
    Str:D         $str  where {         / ^ <[ A..Z a..z \s ]>* $ / },
    List:D[Str:D] $keys where { .all ~~ / ^ <[ A..Z a..z    ]>  $ / }
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;
    my Str  @words = $str.split: / \s+ /, :skip-empty;

    L-WORDS:
    for @words -> Str $word
    {
        for @$keys -> Str $key
        {
            next L-WORDS if $word ~~ / :i $key /;
        }

        ++$count;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $keys-str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $keys-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @keys  = $keys-str.split: / \s+ /, :skip-empty;
        my UInt $count = count-typeable-words( $str, @keys );

        is $count, $expected.Int, $test-name;
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
        Example 1|Hello World         |d  |1
        Example 2|apple banana cherry |a e|0
        Example 3|Coding is fun       |   |3
        Example 4|The Weekly Challenge|a b|2
        Example 5|Perl and Python     |p  |1
        END
}

################################################################################
