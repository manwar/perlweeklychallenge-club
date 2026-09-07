#!perl

################################################################################
=comment

Perl Weekly Challenge 386
=========================

TASK #1
-------
*Reverse Base*

Submitted by: Mohammad Sajid Anwar

You are given a string representing a number, and an integer specifying the base
of that representation.

Write a function to convert this string to an integer. (For bases greater than
10, use characters A-Z, a-z, + and / in that order.)

Example 1

  Input: $num = "101010", $base = 2
  Output: 42

Example 2

  Input: $num = "EEADEE", $base = 16
  Output: 15642094

Example 3

  Input: $num = "755", $base = 8
  Output: 493

Example 4

  Input: $num = "1BRJB", $base = 36
  Output: 2228519

Example 5

  Input: $num = "7MyqL", $base = 64
  Output: 123456789

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
2. A string representing a number, and an integer specifying the base of that
   number, are entered on the command-line.

Assumptions
-----------
1. A valid number ($num) is an integer.
2. A valid base is an integer between 2 and 64, inclusive.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use List::Util     qw( any zip );
use Regexp::Common qw( number );
use Test::More;

const my @DIGITS   => '0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/';
const my %DIG_VAL  => map { @$_ } zip \@DIGITS, [ 0 .. $#DIGITS ];
const my $MIN_BASE =>  2;
const my $MAX_BASE => scalar @DIGITS;
const my $USAGE    => <<END;
Usage:
  perl $0 <num> <base>
  perl $0

    <num>     A string representing an integer
    <base>    An integer base (2 .. 64)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 386, Task #1: Reverse Base (Perl)\n\n";
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
        my ($num, $base) = @ARGV;

        validate_data( $num, $base );

        print qq[Input:  \$num = "$num", \$base = $base\n];

        my $decimal = convert_to_decimal( $num, $base );

        print "Output: $decimal\n";
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub convert_to_decimal
#-------------------------------------------------------------------------------
{
    my ($num, $base) = @_;
    my  $neg = false;

    if ($num =~ / ^ - /x)
    {
        $neg = true;
        $num = substr $num, 1;
    }

    my $decimal    = 0;
    my $multiplier = 1;

    for my $digit (reverse split //, $num)
    {
        $decimal    += $DIG_VAL{ $digit } * $multiplier;
        $multiplier *= $base;
    }

    return $neg ? -$decimal : $decimal;
}

#-------------------------------------------------------------------------------
sub validate_data
#-------------------------------------------------------------------------------
{
    my  ($num, $base) = @_;

    $base =~ / ^ $RE{num}{int} $ /x
        or error( qq["$base" is not a valid integer] );

    $MIN_BASE <= $base <= $MAX_BASE
        or error( "$base is not a valid base" );

    # Check that the digits in $num are valid for $base

    my @digits = @DIGITS[ 0 .. $base - 1 ];
    my @nums   = split //, $num;
    my $start  = $nums[ 0 ] eq '-' ? 1 : 0;

    for my $i ($start .. $#nums)
    {
        my $d = $nums[ $i ];

        any { $_ eq $d } @digits
            or error( qq["$d" is not a valid digit for base $base] );
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num, $base, $expected) = split / \| /x, $line;

        for ($test_name, $num, $base, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        validate_data( $num, $base );

        my $decimal = convert_to_decimal( $num, $base );

        is $decimal, $expected, $test_name;
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
Example 1|101010| 2|        42
Example 2|EEADEE|16|  15642094
Example 3|   755| 8|       493
Example 4| 1BRJB|36|   2228519
Example 5| 7MyqL|64| 123456789
Negative |-7MyqL|64|-123456789
