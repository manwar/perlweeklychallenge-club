#!perl

################################################################################
=comment

Perl Weekly Challenge 312
=========================

TASK #2
-------
*Balls and Boxes*

Submitted by: Mohammad Sajid Anwar

There are $n balls of mixed colors: red, blue or green. They are all distributed
in 10 boxes labelled 0-9.

You are given a string describing the location of balls.

Write a script to find the number of boxes containing all three colors. Return 0
if none found.

Example 1

  Input: $str = "G0B1R2R0B0"
  Output: 1

  The given string describes there are 5 balls as below:
  Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
  Box 1: Blue(B1) => 1 ball
  Box 2: Red(R2) => 1 ball

Example 2

  Input: $str = "G1R3R6B3G6B1B6R1G3"
  Output: 3

  The given string describes there are 9 balls as below:
  Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
  Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
  Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls

Example 3

  Input: $str = "B3B2G1B3"
  Output: 0

  Box 1: Green(G1) => 1 ball
  Box 2: Blue(B2)  => 1 ball
  Box 3: Blue(B3)  => 2 balls

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
2. A string describing the location of coloured balls in numbered boxes is given
   on the command-line.

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string describing the location of balls in boxes
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 312, Task #2: Balls and Boxes (Perl)\n\n";
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

        string_is_valid( $str ) or error( qq[The string "$str" is invalid] );

        printf qq[Input:  \$str = "%s"\n], uc $str;

        my $boxes = count_boxes( $str );

        print "Output: $boxes\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_boxes
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    string_is_valid( $str ) or die qq["$str" is invalid];

    my @boxes;
    my @chars = split //, $str;

    while (@chars)
    {
        my $colour  = uc shift @chars;
        my $box_num =    shift @chars;

        ++$boxes[ $box_num ]->{ $colour };
    }

    my $count = 0;

    for my $i (0 .. 9)
    {
        my $box = $boxes[ $i ];

        ++$count if $box->{ R } && $box->{ B } && $box->{ G };
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub string_is_valid
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return 0 unless (length $str) % 2 == 0;

    my @chars = split //, $str;

    while (@chars)
    {
        my $lhs = shift @chars;
        my $rhs = shift @chars;

        return 0 unless $lhs =~ / ^ [RGB] $ /ix &&
                        $rhs =~ / ^ [0-9] $ /x;
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

        my $boxes = count_boxes( $str );

        is $boxes, $expected, $test_name;
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
Example 1|G0B1R2R0B0        |1
Example 2|G1R3R6B3G6B1B6R1G3|3
Example 3|B3B2G1B3          |0
