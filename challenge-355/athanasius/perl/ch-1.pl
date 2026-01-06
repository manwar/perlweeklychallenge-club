#!perl

################################################################################
=comment

Perl Weekly Challenge 355
=========================

TASK #1
-------
*Thousand Separator*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.

Example 1

  Input: $int = 123
  Output: "123"

Example 2

  Input: $int = 1234
  Output: "1,234"

Example 3

  Input: $int = 1000000
  Output: "1,000,000"

Example 4

  Input: $int = 1
  Output: "1"

Example 5

  Input: $int = 12345
  Output: "12,345"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive integer" is an unsigned integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $DIGIT_COUNT => 3;
const my $SEPARATOR   => ',';
const my $USAGE       => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    A positive integer
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 355, Task #1: Thousand Separator (Perl)\n\n";
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
        my $int = $ARGV[0];

        $int =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$_" is not a valid integer] );
        $int >= 0 or error( "$_ is not positive");

        print "Input:  \$int = $int\n";
        
        my $str = add_separators( $int );

        print qq[Output: "$str"\n];
    }
}

#-------------------------------------------------------------------------------
sub add_separators
#-------------------------------------------------------------------------------
{
    my ($int)   = @_;
    my  @digits = split //, $int;
    my  $count  = 0;
    my  @chars;

    while (@digits)
    {
        unshift @chars, pop @digits;

        if (++$count == $DIGIT_COUNT)
        {
            unshift @chars, $SEPARATOR;
            $count = 0;
        }
    }

    shift @chars if $chars[0] eq $SEPARATOR;

    return join '', @chars;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int, $expected) = split / \| /x, $line;

        for ($test_name, $int, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $str = add_separators( $int );

        is $str, $expected, $test_name;
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
Example 1|      123|        123
Example 2|     1234|      1,234
Example 3|  1000000|  1,000,000
Example 4|        1|          1
Example 5|    12345|     12,345
3 x 3    |987654321|987,654,321
