#!perl

################################################################################
=comment

Perl Weekly Challenge 386
=========================

TASK #2
-------
*Rational Numbers*

Submitted by: Mohammad Sajid Anwar

You are given two strings representing non-negative rational numbers.

Write a script to return true if the two given rational numbers are same other-
wise false.

Example 1

  Input: $rat1 = "0.(12)"
         $rat2 = "0.(121)"
  Output: false

  Expansion of "0.(12)"  = 0.12 12 12 12
  Expansion of "0.(121)" = 0.121 121 121

Example 2

  Input: $rat1 = "0.1(23)"
         $rat2 = "0.12(32)"
  Output: true

  Expansion of "0.1(23)"  = 0.1 23 23 23
  Expansion of "0.12(32)" = 0.12 32 32 32

Example 3

  Input: $rat1 = "0.1(234)"
         $rat2 = "0.12(342)"
  Output: true

  Expansion of "0.1(234)"  = 0.1 234 234 234
  Expansion of "0.12(342)" = 0.12 342 342 342

Example 4

  Input: $rat1 = "12.99(99)"
         $rat2 = "13."
  Output: true

Example 5

  Input: $rat1 = "0.(123)"
         $rat2 = "0.1(231)"
  Output: true

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
2. Two strings, each representing a non-negative rational number, are entered on
   the command-line.
3. If $VERBOSE is set to a true value, the output ("true" or "false") is follow-
   ed by a short explanation detailing how each input string has been interpret-
   ed as a rational number (in normalised form).

=cut
#===============================================================================

use v5.38.2;      # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use List::Util    qw( max );
use Math::BigRat;
use Test::More;

const my $VERBOSE => true;
const my $USAGE   => <<END;
Usage:
  perl $0 <rat1> <rat2>
  perl $0

    <rat1>    First  non-negative rational number
    <rat2>    Second non-negative rational number
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 386, Task #2: Rational Numbers (Perl)\n\n";
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
        my ($rat1, $rat2) = @ARGV;

        print qq[Input:  \$rat1 = "$rat1"\n];
        print qq[        \$rat2 = "$rat2"\n];

        my ($equal, $r1, $r2) = are_equal( $rat1, $rat2 );

        printf "Output: %s\n", $equal ? 'true' : 'false';

        if ($VERBOSE)
        {
            my $width = max( length $rat1, length $rat2 ) + 2;

            print  "\nExplanation:\n";
            printf "  %-*s = %s\n", $width, qq["$rat1"], format_rat( $r1 );
            printf "  %-*s = %s\n", $width, qq["$rat2"], format_rat( $r2 );
        }
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub are_equal
#-------------------------------------------------------------------------------
{
    my ($rat1, $rat2) = @_;

    my  $r1 = parse_rational( $rat1 );
    my  $r2 = parse_rational( $rat2 );

    return ($r1 == $r2, $r1, $r2);
}

#-------------------------------------------------------------------------------
sub parse_rational
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $rat;

    $rat = Math::BigRat->new( $str );

    if ($rat->is_nan)
    {
        $rat =  parse_repeating( $str );
        $rat // error( qq["$str" is not a valid rational number], true ) ;
    }

    error( qq["$str" is negative], true ) if $rat < 0;

    return $rat;
}

#-------------------------------------------------------------------------------
sub parse_repeating
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  $rat;

    if ($str =~ / ^ ([+-]? \d+) \. (\d*) \( (\d+) \) $ /x)
    {
        my ($int, $fixed, $rep) = @{ ^CAPTURE };

        my  $x     = $int . $fixed;
        my  $y     = $x   . $rep;
        my  $diff  = $y   - $x;
        my  $mult1 = 10 **  length( $fixed );
        my  $mult2 = 10 ** (length( $fixed ) + length( $rep ));

        $rat = Math::BigRat->new( Math::BigInt->new( $diff ),
                                  Math::BigInt->new( $mult2 - $mult1 ) );
    }

    return $rat;
}

#-------------------------------------------------------------------------------
sub format_rat
#-------------------------------------------------------------------------------
{
    my ($rat) = @_;

    return sprintf "%d/%d", $rat->numerator, $rat->denominator;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $rat1, $rat2, $expected) = split / \| /x, $line;

        for ($test_name, $rat1, $rat2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $equal = (are_equal( $rat1, $rat2 ))[0] ? 'true' : 'false';

        is $equal, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message, $prepend_newline) = @_;

    print "\n" if $prepend_newline;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1| 0.(12)  | 0.(121)  |false
Example 2| 0.1(23) | 0.12(32) |true
Example 3| 0.1(234)| 0.12(342)|true
Example 4|12.99(99)|13.       |true
Example 5| 0.(123) | 0.1(231) |true
