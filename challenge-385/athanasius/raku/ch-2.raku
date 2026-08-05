use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 385
=========================

TASK #2
-------
*Outermost Parentheses*

Submitted by: Mohammad Sajid Anwar

You are given a valid parentheses string.

Write a script to return the string after removing the outermost parentheses of
every primitive string in the primitive decomposition of the given string.

Example 1

  Input: $str = "()()()"
  Output: ""

  Primitive Decomposition: "()" + "()" + "()"

Example 2

  Input: $str = "(((())))"
  Output: "((()))"

  Primitive Decomposition: "(((())))"

Example 3

  Input: $str = "(()())(())"
  Output: "()()()"

  Primitive Decomposition: "(()())" + "(())"

Example 4

  Input: $str = "()((()))()"
  Output: "(())"

  Primitive Decomposition: "()" + "((()))" + "()"

Example 5

  Input: $str = "(()(()))(()())"
  Output: "()(())()()"

  Primitive Decomposition: "(()(()))" + "(()())"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

Assumption
----------
A "valid parentheses string" is a string containing only balanced parentheses:

  "An expression is balanced if each opening bracket has a corresponding closing
  bracket of the same type, the pairs are properly ordered and no bracket closes
  before its matching opening bracket." [1]

References
----------
[1] https://www.geeksforgeeks.org/dsa/check-for-balanced-parentheses-in-an-
    expression/
[2] https://docs.raku.org/language/regexes#index-entry-<~~>

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 385, Task #2: Outermost Parentheses (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where / ^ <[ ( ) ]>* $ /      #= A string of balanced parentheses
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str $trimmed = remove-outermost-parens( $str );

    qq[Output: "$trimmed"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub remove-outermost-parens( Str:D $str where / ^ <[ ( ) ]>* $ / --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $trimmed = '';

    # See "Recursive Regexes" under _Regexes_ in the Raku documentation [2]

    my $re-bal = rx/ '(' <~~>* ')' /;

    $str ~~ / ^ ($re-bal*) $ / or error( 'Unbalanced parentheses' );

    for $str ~~ m:g/ $re-bal /
    {
        / ^ . (.*) . $ /;           # Trim first and last parentheses

        $trimmed ~= $0;
    }

    return $trimmed;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $trimmed = remove-outermost-parens( $str );

        is $trimmed, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1|()()()        |
        Example 2|(((())))      |((()))
        Example 3|(()())(())    |()()()
        Example 4|()((()))()    |(())
        Example 5|(()(()))(()())|()(())()()
        Empty    |              |
        END
}

################################################################################
