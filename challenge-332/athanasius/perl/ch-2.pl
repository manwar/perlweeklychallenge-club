#!perl

################################################################################
=comment

Perl Weekly Challenge 332
=========================

TASK #2
-------
*Odd Letters*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find out if each letter in the given string appeared odd
number of times.

Example 1

  Input: $str = "weekly"
  Output: false

  w: 1 time
  e: 2 times
  k: 1 time
  l: 1 time
  y: 1 time

  The letter 'e' appeared 2 times i.e. even.

Example 2

  Input: $str = "perl"
  Output: true

Example 3

  Input: $source = "challenge"
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string is entered on the command-line.

Assumptions
-----------
1. Non-letter characters in the string are ignored.
2. The identification of a letter is not case-sensitive; so, e.g., 'a' and 'A'
   are considered the same letter.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert qw( on );
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
    print "\nChallenge 332, Task #2: Odd Letters (Perl)\n\n";
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
        my ($str) =  @ARGV;

        print qq[Input:  \$str = "$str"\n];

        my $all_odd = all_letters_odd( $str );

        printf "Output: %s\n", $all_odd ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub all_letters_odd
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @chars = split //, $str;
    my  %dict;

    for my $char (@chars)
    {
        ++$dict{ lc $char } if $char =~ / ^ [A-Za-z] $ /x;
    }

    for my $val (values %dict)
    {
        return '' if $val % 2 == 0;
    }

    return 1;
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

        my $all_odd = all_letters_odd( $str ) ? 'true' : 'false';

        is $all_odd, $expected, $test_name;
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
Example 1   |weekly   |false
Example 2   |perl     |true
Example 3   |challenge|false
Mixed case 1|Test1    |false
Mixed case 2|**ee4E%% |true
