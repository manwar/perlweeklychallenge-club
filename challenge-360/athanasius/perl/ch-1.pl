#!perl

################################################################################
=comment

Perl Weekly Challenge 360
=========================

TASK #1
-------
*Text Justifier*

Submitted by: Mohammad Sajid Anwar

You are given a string and a width.

Write a script to return the string that centers the text within that width
using asterisks * as padding.

Example 1

  Input: $str = "Hi", $width = 5
  Output: "*Hi**"

  Text length = 2, Width = 5
  Need 3 padding characters total
  Left padding: 1 star, Right padding: 2 stars

Example 2

  Input: $str = "Code", $width = 10
  Output: "***Code***"

  Text length = 4, Width = 10
  Need 6 padding characters total
  Left padding: 3 stars, Right padding: 3 stars

Example 3

  Input: $str = "Hello", $width = 9
  Output: "**Hello**"

  Text length = 5, Width = 9
  Need 4 padding characters total
  Left padding: 2 stars, Right padding: 2 stars

Example 4

  Input: $str = "Perl", $width = 4
  Output: "Perl"

  No padding needed

Example 5

  Input: $str = "A", $width = 7
  Output: "***A***"

  Text length = 1, Width = 7
  Need 6 padding characters total
  Left padding: 3 stars, Right padding: 3 stars

Example 6

  Input: $str = "", $width = 5
  Output: "*****"

  Text length = 0, Width = 5
  Entire output is padding

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. An input width less that the length of the input string is to be treated as
   an error.
2. If the string cannot be exactly justified within the given width, its dis-
   tance from the left of the justified string shall be one character less than
   its distance from the right (see Example 1).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string to be justified is entered on the command-line, followed by the
   width of the field within which the string is to be justified. The width must
   be at least as great as the length of the string. 

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $PADDING => '*';
const my $USAGE   => <<END;
Usage:
  perl $0 <str> <width>
  perl $0

    <str>      String to be justified
    <width>    Width (at least the length of <str>)
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 360, Task #1: Text Justifier (Perl)\n\n";
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
        my ($str, $width) = @ARGV;

        $width =~ / ^ $RE{num}{int} $ /x
                              or error( qq["$width" is not a valid integer] );
        $width >= length $str or error( "The width $width is too small" );

        print qq[Input:  \$str = "$str", \$width = $width\n];

        my $justified = justify_text( $str, $width );

        print qq[Output: "$justified"\n];
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub justify_text
#-------------------------------------------------------------------------------
{
    my ($str, $width) = @_;

    $width >= length $str
        or die qq[Width $width is too small for string "$str"];

    my $diff   = $width - length $str;
    my $prefix = $PADDING x int( $diff / 2 );
    my $suffix = $PADDING x ($diff - length $prefix);

    return $prefix . $str . $suffix;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $width, $expected) = split / \| /x, $line;

        for ($test_name,       $width, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $justified = justify_text( $str, $width );

        is $justified, $expected, $test_name;
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
Example 1|Hi|   5|*Hi**
Example 2|Code|10|***Code***
Example 3|Hello|9|**Hello**
Example 4|Perl| 4|Perl
Example 5|A|    7|***A***
Example 6||     5|*****
