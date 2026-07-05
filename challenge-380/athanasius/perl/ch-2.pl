#!perl

################################################################################
=comment

Perl Weekly Challenge 380
=========================

TASK #2
-------
*Reverse Degree*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find the reverse degree of the given string.

  For each character, multiply its position in the reversed alphabet ('a' = 26,
  'b' = 25, ..., 'z' = 1) with its position in the string. Sum these products
  for all characters in the string to get the reverse degree.

Example 1

  Input: $str = "z"
  Output: 1

  Reverse alphabet value of "z" is 1.
  Position 1: 1 x 1
  Sum of product: 1

Example 2

  Input: $str = "a"
  Output: 26

  Reverse alphabet value of "a" is 26.
  Position 1: 1 x 26
  Sum of product: 26

Example 3

  Input: $str = "bbc"
  Output: 147

  Reverse alphabet value of "b" is 25 and "c" is 24.
  Position 1: 1 x 25
  Position 2: 2 x 25
  Position 3: 3 x 24
  Sum of product: 25 + 50 + 72 => 147

Example 4

  Input: $str = "racecar"
  Output: 560

  Reverse alphabet value of "r" is 9, "a" is 26, "c" is 24 and "e" is 24.
  Position 1: 1 x 9
  Position 2: 2 x 26
  Position 3: 3 x 24
  Position 4: 4 x 22
  Position 5: 5 x 24
  Position 6: 6 x 26
  Position 7: 7 x 9
  Sum of product: 9 + 52 + 72 + 88 + 120 + 156 + 63

Example 5

  Input: $str = "zyx"
  Output: 14

  Reverse alphabet value of "z" is 1, "y" is 2 and "x" is 3.
  Position 1: 1 x 1
  Position 2: 2 x 2
  Position 3: 3 x 3
  Sum of product: 1 + 4 + 9

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

Assumption
----------
The mapping of letters to values is the same for upper- as for lower-case:
    'A', 'a' => 26,
    'B', 'b' => 25,
          ...
    'Z', 'z' =>  1.

=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( mesh );
use Test::More;

const my %REV_ALPHA => mesh [ 'a' .. 'z' ]->@*, [ reverse 1 .. 26 ]->@*;
const my $USAGE     => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of letters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 380, Task #2: Reverse Degree (Perl)\n\n";
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
            $str  =~ / ^ [a-z]* $ /ix or error( qq[String "$str" is invalid] );

        print qq[Input:  \$str = "$str"\n];

        my $degree = find_reverse_degree( $str );

        print "Output: $degree\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_reverse_degree
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [a-z]* $ /ix or die qq[String "$str" is invalid];
    my  $sum  =  0;
    my  $i    =  1;

    for my $char (split //, $str)
    {
        $sum += $REV_ALPHA{ lc $char } * $i++;
    }

    return $sum;
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

        my $degree = find_reverse_degree( $str );

        is $degree, $expected, $test_name;
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
Example 1 |z      |  1
Example 2 |a      | 26
Example 3 |bbc    |147
Example 4 |racecar|560
Example 5 |zyx    | 14
Upper case|ZYX    | 14
Empty     |       |  0
