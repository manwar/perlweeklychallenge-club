#!perl

################################################################################
=comment

Perl Weekly Challenge 314
=========================

TASK #1
-------
*Equal Strings*

Submitted by: Mohammad Sajid Anwar

You are given three strings.

You are allowed to remove the rightmost character of a string to make all
equals.

Write a script to return the number of operations to make it equal otherwise -1.

Example 1

  Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
  Output: 2

  Operation 1: Delete "c" from the string "abc"
  Operation 2: Delete "b" from the string "abb"

Example 2

  Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
  Output: -1

Example 3

  Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
  Output: 3

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Removal of the rightmost character may be performed only once on each string.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Three strings are entered on the command-line.

Analysis
--------
There are 8 possible sets of operations ('x' = remove rightmost char):

    #   s1      s2      s3      Output
--------------------------------------
    1    -       -       -        0
    2    x       -       -        1
    3    -       x       -        1
    4    -       -       x        1
    5    x       x       -        2
    6    x       -       x        2
    7    -       x       x        2
    8    x       x       x        3

and 5 possible outcomes:  -1, 0, 1, 2, 3

=cut
#===============================================================================

use v5.32;          # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <s1> <s2> <s3>
  perl $0

    <s1>    First  string
    <s2>    Second string
    <s3>    Third  string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 314, Task #1: Equal Strings (Perl)\n\n";
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
    elsif ($argc == 3)
    {
        my ($s1, $s2, $s3) = @ARGV;

        print qq[Input:  \$s1 = "$s1", \$s2 = "$s2", \$s3 = "$s3"\n];

        my $operations = solve( $s1, $s2, $s3 );

        print "Output: $operations\n";
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($s1, $s2, $s3) = @_;

    return  0 if equal(      $s1,        $s2,        $s3   );

    return  1 if equal( chp( $s1 ),      $s2,        $s3   ) ||
                 equal(      $s1,   chp( $s2 ),      $s3   ) ||
                 equal(      $s1,        $s2,   chp( $s3 ) );

    return  2 if equal( chp( $s1 ), chp( $s2 ),      $s3   ) ||
                 equal( chp( $s1 ),      $s2,   chp( $s3 ) ) ||
                 equal(      $s1,   chp( $s2 ), chp( $s3 ) );

    return  3 if equal( chp( $s1 ), chp( $s2 ), chp( $s3 ) );

    return -1;
}

#-------------------------------------------------------------------------------
sub chp                            # Like chop(), but returns the chopped string
#-------------------------------------------------------------------------------
{
    return substr $_[ 0 ], 0, -1;
}

#-------------------------------------------------------------------------------
sub equal
#-------------------------------------------------------------------------------
{
    return $_[ 0 ]  eq $_[ 1 ] && $_[ 1 ] eq $_[ 2 ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $s1, $s2, $s3, $expected) = split / \| /x, $line;

        for ($test_name, $s1, $s2, $s3, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $operations = solve( $s1, $s2, $s3 );

        is $operations, $expected, $test_name;
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
Example 1|abc|abb|ab | 2
Example 2|ayz|cyz|xyz|-1
Example 3|yza|yzb|yzc| 3
All same |ABC|ABC|ABC| 0
