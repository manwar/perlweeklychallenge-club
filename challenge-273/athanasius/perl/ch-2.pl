#!perl

################################################################################
=comment

Perl Weekly Challenge 273
=========================

TASK #2
-------
*B After A*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to return true if there is at least one b, and no a appears after
the first b.

Example 1

  Input: $str = "aabb"
  Output: true

Example 2

  Input: $str = "abab"
  Output: false

Example 3

  Input: $str = "aaa"
  Output: false

Example 4

  Input: $str = "bbb"
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Character comparisons are NOT case-sensitive; i.e., "A" is the same character as
"a", and "B" is the same character as "b".

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input string is entered on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 273, Task #2: B After A (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        print qq[Input:  \$str = "$str"\n];

        my $b_after_a = b_after_a( $str );

        printf "Output: %s\n", $b_after_a ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub b_after_a
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return $str =~ / ^ [^b]* b [^a]* $ /ix;
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

        my $b_after_a = b_after_a( $str ) ? 'true' : 'false';

        is $b_after_a, $expected, $test_name;
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
Example 1  |aabb |true
Example 2  |abab |false
Example 3  |aaa  |false
Example 4  |bbb  |true
Uppercase 1|AABB |true
Uppercase 2|aBAb |false
Uppercase 3|aAa  |false
Uppercase 4|Bbb  |true
First B    |ababx|false
Second B   |abxba|false
