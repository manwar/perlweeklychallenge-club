#!perl

################################################################################
=comment

Perl Weekly Challenge 273
=========================

TASK #1
-------
*Percentage of Character*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character $char.

Write a script to return the percentage, nearest whole, of given character in
the given string.

Example 1

  Input: $str = "perl", $char = "e"
  Output: 25

Example 2

  Input: $str = "java", $char = "a"
  Output: 50

Example 3

  Input: $str = "python", $char = "m"
  Output: 0

Example 4

  Input: $str = "ada", $char = "a"
  Output: 67

Example 5

  Input: $str = "ballerina", $char = "l"
  Output: 22

Example 6

  Input: $str = "analitik", $char = "k"
  Output: 13

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input string and character are entered as unnamed (positional) arguments
   on the command-line.
3. If "--ignore-case" is entered on the command-line, "X" and "x" (for example)
   are treated as the same character; otherwise, the default behaviour is to
   treat them as different characters.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--ignore-case] <str> <char>
  perl $0

    <str>            A string
    <char>           A character
    --ignore-case    "X" and "x" are the same character [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 273, Task #1: Percentage of Character (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($str, $char, $ignore_case) = parse_command_line();

        print qq[Input:  \$str = "$str", \$char = "$char"\n];

        my $percent = find_percentage( $str, $char, $ignore_case );

        print "Output: $percent\n";
    }
}

#-------------------------------------------------------------------------------
sub find_percentage
#-------------------------------------------------------------------------------
{
    my ($str, $orig_char, $ignore_case) = @_;

    return 0 if length $str == 0;                       # Avoid division by zero

    my $count = 0;
    my $char  = $ignore_case ? lc $orig_char : $orig_char;

    for my $orig_c (split //, $str)
    {
        my $c = $ignore_case ? lc $orig_c    : $orig_c;

        ++$count if $c eq $char;
    }

    return int( (($count / length $str) * 100) + 0.5 );
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $ignore_case;

    GetOptions
    (
        'ignore-case' => \$ignore_case

    )   or error( 'Invalid command-line argument(s)' );

    my $argc = scalar @ARGV;

    $argc == 2
        or error( "Expected 0, 2, or 3 command-line arguments, found $argc" );

    my ($str, $char) = @ARGV;

    length $char == 1
        or error( qq[Invalid char "$char"] );

    return ($str, $char, $ignore_case);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $char, $ignore_case, $expected) =
             split / \| /x, $line;

        for ($test_name, $str, $char, $ignore_case, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $percent = find_percentage( $str, $char, $ignore_case );

        ok $percent == $expected, $test_name;
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
Example 1    |perl     |e|0| 25
Example 2    |java     |a|0| 50
Example 3    |python   |m|0|  0
Example 4    |ada      |a|0| 67
Example 5    |ballerina|l|0| 22
Example 6    |analitik |k|0| 13
Empty string |         |a|0|  0
Same chars   |jjjjj    |j|0|100
Ignore case 1|Aardvark |A|1| 38
Ignore case 2|Aardvark |a|1| 38
Use case 1   |Aardvark |A|0| 13
Use case 2   |Aardvark |a|0| 25
