#!perl

################################################################################
=comment

Perl Weekly Challenge 329
=========================

TASK #1
-------
*Counter Integers*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to replace every non-digit character with a space and then return
all the distinct integers left.

Example 1

  Input: $str = "the1weekly2challenge2"
  Output: 1, 2

  2 is appeared twice, so we count it one only.

Example 2

  Input: $str = "go21od1lu5c7k"
  Output: 21, 1, 5, 7

Example 3

  Input: $str = "4p3e2r1l"
  Output: 4, 3, 2, 1

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
2. A string containing only digits and lower-case English letters is entered on
   the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string containing only digits and lower-case English letters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 329, Task #1: Counter Integers (Perl)\n\n";
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

        $str =~ / ([^a-z0-9]) /x and error( qq[Invalid character "$1"] );

        print qq[Input: \$str = "$str"\n];

        my $ints = find_ints( $str );

        printf "Output: %s\n", join ', ', @$ints;
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_ints
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
        $str  =~ / ([^a-z0-9]) /x and die qq[Invalid character "$1"];

    my (@ints, %dict);

    for my $int (grep { length } split / [^0-9]+ /x, $str)
    {
        push @ints, $int if ++$dict{ $int } == 1;
    }

    return \@ints;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected_str) = split / \| /x, $line;

        for ($test_name, $str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $ints = find_ints( $str );
        my @exp  = split / \s+ /x, $expected_str;

        is_deeply $ints, \@exp, $test_name;
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
Example 1|the1weekly2challenge2| 1 2
Example 2|go21od1lu5c7k        |21 1 5 7
Example 3|4p3e2r1l             | 4 3 2 1
