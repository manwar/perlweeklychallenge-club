#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Characters are case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty string is entered on the command-line, followed by a single
   character in the given string.
   
=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> <char>
  perl $0

    <str>     A non-empty string
    <char>    A character in the given string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 341, Task #2: Reverse Prefix (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($str, $char) = @ARGV;

        length( $str  ) >  0 or error( 'The input string is empty' );
        length( $char ) == 1 or error( qq["$char" is not a character] );

        $str =~ /$char/
            or error( qq["$char" is not a character in the string "$str"] );

        print qq[Input: \$str = "$str", \$char = "$char"\n];

        my $rev = reverse_prefix( $str, $char );

        print qq[Output:       "$rev"\n];
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_prefix
#-------------------------------------------------------------------------------
{
    my ($str, $char)   = @_;
    my ($first, $last) = split /$char/, $str, 2;

    return $char . reverse( $first ) . $last;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $char, $expected) = split / \| /x, $line;

        for ($test_name, $str, $char, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $rev = reverse_prefix( $str, $char );

        is $rev, $expected, $test_name;
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
Example 1|programming|g|gorpramming
Example 2|hello      |h|hello
Example 3|abcdefghij |h|hgfedcbaij
Example 4|reverse    |s|srevere
Example 5|perl       |r|repl
