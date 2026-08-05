#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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

Reference
---------
[1] https://www.geeksforgeeks.org/dsa/check-for-balanced-parentheses-in-an-
    expression/

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;
use Text::Balanced qw( extract_bracketed );

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of balanced parentheses
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 385, Task #2: Outermost Parentheses (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $str =  $ARGV[0];
           $str =~ / ^ [\(\)]* $ /x
                   or error( qq["$str" is not a valid parentheses string] );

        print qq[Input:  \$str = "$str"\n];

        my $trimmed = remove_outermost_parens( $str );

        print qq[Output: "$trimmed"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub remove_outermost_parens
#-------------------------------------------------------------------------------
{
    my ($str)    = @_;
    my  $trimmed = '';

    if ($str)
    {
        while (my ($extracted, $remainder) = extract_bracketed( $str, '()' ))
        {
            $extracted // error( 'Unbalanced parentheses' );
            $extracted =~ / ^ . (.*) . $ /x;
            $trimmed  .=  $1;

            last if $remainder eq '';
        }
    }

    return $trimmed;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $trimmed = remove_outermost_parens( $str );

        is $trimmed, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|()()()        |
Example 2|(((())))      |((()))
Example 3|(()())(())    |()()()
Example 4|()((()))()    |(())
Example 5|(()(()))(()())|()(())()()
Empty    |              |
