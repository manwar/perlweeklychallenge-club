use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 346
=========================

TASK #1
-------
*Longest Parenthesis*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only ( and ).

Write a script to find the length of the longest valid parenthesis.

Example 1

  Input: $str = '(()())'
  Output: 6

  Valid Parenthesis: '(()())'

Example 2

  Input: $str = ')()())'
  Output: 4

  Valid Parenthesis: '()()' at positions 1-4.

Example 3

  Input: $str = '((()))()(((()'
  Output: 8

  Valid Parenthesis: '((()))()' at positions 0-7.

Example 4

  Input: $str = '))))((()('
  Output: 2

  Valid Parenthesis: '()' at positions 6-7.

Example 5

  Input: $str = '()(()'
  Output: 2

  Valid Parenthesis: '()' at positions 0-1 and 3-4.

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
2. A single string, containing only left and right parentheses, is entered on
   the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 346, Task #1: Longest Parenthesis (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where { / ^ <[()]>* $ / }     #= A string containing only ( and )
)
#===============================================================================
{
    "Input:  \$str = '$str'".put;

    my UInt $len = find-longest-paren-len( $str );

    "Output: $len".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-longest-paren-len( Str:D $string where { / ^ <[()]>* $ / } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Str  $str      =  $string;
            $str      ~~ s/ ^ \)+   //;
            $str      ~~ s/   \(+ $ //;
    my UInt $max-len  =  0;
    my Int  $last-idx =  $str.chars - 1;
    my UInt $start    =  0;
    my Int  $last-end = -2;
    my UInt $last-len =  0;

    while $last-idx > $start
    {
        my UInt $count = 1;
        my Bool $found = False;

        for $start + 1 .. $last-idx -> UInt $end
        {
            if    $str.substr( $end, 1 ) eq '('
            {
                ++$count;
            }
            elsif --$count == 0        # Match found
            {
                my UInt $len  = $end - $start + 1;
                        $len += $last-len if $start == $last-end + 1;

                $max-len  = ($len, $max-len).max;
                $last-end =  $end;
                $last-len =  $len;
                $found    =  True;
                $start    =  $end + 1;

                ++$start while $str.substr( $start, 1 ) eq ')';

                last;
            }
        }

        ++$start unless $found;        # No match: advance 1 char & search again
    }

    return $max-len;
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

        my UInt $len = find-longest-paren-len( $str );

        is $len, $expected.Int, $test-name;
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
        Example 1|(()())       |6|(()())
        Example 2|)()())       |4|()()     at positions 1-4
        Example 3|((()))()(((()|8|((()))() at positions 0-7
        Example 4|))))((()(    |2|()       at positions 6-7
        Example 5|()(()        |2|()       at positions 0-1 and 3-4
        2 matches|())(())      |4|(())     at positions 3-6
        END
}

################################################################################
