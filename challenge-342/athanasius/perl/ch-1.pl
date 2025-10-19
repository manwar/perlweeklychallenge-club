#!perl

################################################################################
=comment

Perl Weekly Challenge 342
=========================

TASK #1
-------
*Balance String*

Submitted by: Mohammad Sajid Anwar

You are given a string made up of lowercase English letters and digits only.

Write a script to format the give[n] string where no letter is followed by
another letter and no digit is followed by another digit. If there are multiple
valid rearrangements, always return the lexicographically smallest one. Return
empty string if it is impossible to format the string.

Example 1

  Input: $str = "a0b1c2"
  Output: "0a1b2c"

Example 2

  Input: $str = "abc12"
  Output: "a1b2c"

Example 3

  Input: $str = "0a2b1c3"
  Output: "0a1b2c3"

Example 4

  Input: $str = "1a23"
  Output: ""

Example 5

  Input: $str = "ab123"
  Output: "1a2b3"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Digits are lexicographically "lower" than letters (as in ASCII, but not EBCDIC).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single, non-empty string, comprising lowercase English letters and digits
   only, is entered on the command-line.

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

    <str>    A non-empty string of lowercase English letters and digits
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 342, Task #1: Balance String (Perl)\n\n";
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

        $str =~  / ^ [0-9a-z]+ $ /x or error( qq[Invalid string "$str"] );

        print qq[Input: \$str = "$str"\n];

        my $balanced = balance_string( $str );

        print qq[Output:       "$balanced"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub balance_string
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [0-9a-z]+ $ /x or die qq[Invalid string "$str"];
    my (@digits, @letters);

    for my $char (split //, $str)
    {
        my    $target = $char =~ / [0-9] /x ? \@digits : \@letters;
        push @$target,  $char;
    }

    @digits  = sort { $a <=> $b } @digits;
    @letters = sort { $a cmp $b } @letters;

    my  $balanced  = '';

    if    (scalar @digits == scalar @letters + 1)
    {
        $balanced  = shift  @digits;
        $balanced .= shift( @letters ) . shift( @digits  ) while @letters;
    }
    elsif (scalar @digits == scalar @letters)
    {
        $balanced .= shift( @digits  ) . shift( @letters ) while @digits;
    }
    elsif (scalar @digits == scalar @letters - 1)
    {
        $balanced  = shift  @letters;
        $balanced .= shift( @digits  ) . shift( @letters ) while @digits;
    }

    return $balanced;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $balanced = balance_string( $str );

        is $balanced, $expected, $test_name;
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
Example 1|a0b1c2 |0a1b2c
Example 2|abc12  |a1b2c
Example 3|0a2b1c3|0a1b2c3
Example 4|1a23   |
Example 5|ab123  |1a2b3
