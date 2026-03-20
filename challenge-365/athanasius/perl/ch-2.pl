#!perl

################################################################################
=comment

Perl Weekly Challenge 365
=========================

TASK #2
-------
*Valid Token Counter*

Submitted by: Mohammad Sajid Anwar

You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count
how many are valid words. A token is valid if it contains no digits, has at most
one hyphen surrounded by lowercase letters, and at most one punctuation mark (!,
., ,) appearing only at the end.

Example 1

  Input: $str = "cat and dog"
  Output: 3

  Tokens: "cat", "and", "dog"

Example 2

  Input: $str = "a-b c! d,e"
  Output: 2

  Tokens: "a-b", "c!", "d,e"
  "a-b" -> valid (one hyphen between letters)
  "c!"  -> valid (punctuation at end)
  "d,e" -> invalid (punctuation not at end)

Example 3

  Input: $str = "hello-world! this is fun"
  Output: 4

  Tokens: "hello-world!", "this", "is", "fun"
  All satisfy the rules.

Example 4

  Input: $str = "ab- cd-ef gh- ij!"
  Output: 2

  Tokens: "ab-", "cd-ef", "gh-", "ij!"
  "ab-"   -> invalid (hyphen not surrounded by letters)
  "cd-ef" -> valid
  "gh-"   -> invalid
  "ij!"   -> valid

Example 5

  Input: $str = "wow! a-b-c nice."
  Output: 2

  Tokens: "wow!", "a-b-c", "nice."
  "wow!"  -> valid
  "a-b-c" -> invalid (more than one hyphen)
  "nice." -> valid

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Valid tokens contain only letters and specified punctuation characters (viz.,
hyphen, exclamation mark, full stop, comma). Other characters (e.g., "@", "*")
render a token invalid.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A sentence
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 365, Task #2: Valid Token Counter (Perl)\n\n";
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
        my $str = $ARGV[0];

        print qq[Input:  \$str = "$str"\n];

        my $count = count_valid_tokens( $str );

        print "Output: $count\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_valid_tokens
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  $count = 0;

    for my $token (split / \s+ /x, $str)
    {
        # A token is valid if [and only if] it:

        # (1) contains no digits [or other non-specified characters]

        next if $token !~ / ^ [-A-Za-z!.,]* $ /x;

        # (2) has at most one hyphen surrounded by lowercase letters

        my $hyphens = $token =~ tr/-//;

        next if $hyphens > 1;

        if ($hyphens == 1)
        {
            next unless $token =~ / [[:lower:]] \- [[:lower:]] /x;
        }

        # (3) has at most one punctuation mark appearing only at the end

        next if $token =~ / [!.,] . /x;

        ++$count;       # If we get here, the token is valid
    }

    return $count;
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

        my $count = count_valid_tokens( $str );

        is $count, $expected, $test_name;
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
Example 1|cat and dog             |3
Example 2|a-b c! d,e              |2
Example 3|hello-world! this is fun|4
Example 4|ab- cd-ef gh- ij!       |2
Example 5|wow! a-b-c nice.        |2
Digit    |c4t and dog             |2
Ampersand|cat &nd dog             |2
