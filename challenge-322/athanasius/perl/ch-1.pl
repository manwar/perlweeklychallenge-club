#!perl

################################################################################
=comment

Perl Weekly Challenge 322
=========================

TASK #1
-------
*String Format*

Submitted by: Mohammad Sajid Anwar

You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of size
given by the integer. The first group can be smaller than the integer but should
have at least one character. Groups should be separated by dashes.

Example 1

  Input: $str = "ABC-D-E-F", $i = 3
  Output: "ABC-DEF"

Example 2

  Input: $str = "A-BC-D-E", $i = 2
  Output: "A-BC-DE"

Example 3

  Input: $str = "-A-B-CD-E", $i = 4
  Output: "A-BCDE"

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
2. A string, and a positive (non-zero) integer, are entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> <i>
  perl $0

    <str>    A string
    <i>      A positive (non-zero) integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 322, Task #1: String Format (Perl)\n\n";
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
        my ($str, $i) = @ARGV;

        $i =~ / ^ $RE{num}{int} $ /x
               or error( qq["$i" is not a valid integer] );

        $i > 0 or error( "$i is not positive" );

        print qq[Input:  \$str = "$str", \$i = $i\n];

        my $grouped = format_string( $str, $i );

        print qq[Output: "$grouped"\n];
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub format_string
#-------------------------------------------------------------------------------
{
    my ($str, $i) = @_;
    my  $bare     = $str =~ s/ \- //grx;
    my  @groups;

    while ($bare =~ s/ ( .{1,$i} ) $ //x)
    {
        unshift @groups, $1;
    }

    return join '-', @groups;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $i, $expected) = split / \| /x, $line;

        for ($test_name, $str, $i, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $grouped = format_string( $str, $i );

        is $grouped, $expected, $test_name;
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
Example 1|ABC-D-E-F|3|ABC-DEF
Example 2|A-BC-D-E |2|A-BC-DE
Example 3|-A-B-CD-E|4|A-BCDE
