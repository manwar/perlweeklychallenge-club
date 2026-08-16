use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string representing a number, and an integer specifying the base of that
   number, are entered on the command-line.
3. If the input number is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

Assumptions
-----------
1. A valid number ($num) is an integer.
2. A valid base is an integer between 2 and 64, inclusive.

=end comment
#===============================================================================

use Test;

my      constant @DIGITS   = Array[Str].new: |('0' .. '9'), |('A' .. 'Z'),
                                             |('a' .. 'z'),   '+',   '/';
my      constant %DIG-VAL  = Hash[UInt].new: (@DIGITS Z 0 .. @DIGITS.end).map:
                                             { @_[ 0 ] => @_[ 1 ] };
my UInt constant $MIN-BASE = 2;
my UInt constant $MAX-BASE = @DIGITS.elems;

subset Base of Int where $MAX-BASE >= * >= $MIN-BASE;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 386, Task #1: Reverse Base (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D  $num,              #= A string representing an integer
    Base:D $base              #= An integer base (2 .. 64)
)
#===============================================================================
{
    validate-data( $num, $base );

    qq[Input:  \$num = "$num", \$base = $base].put;

    my Int $decimal = convert-to-decimal( $num, $base );

    "Output: $decimal".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub convert-to-decimal( Str:D $num is copy, Base:D $base --> Int:D )
#-------------------------------------------------------------------------------
{
    my Bool $neg = False;

    if $num ~~ / ^ \- /
    {
        $neg  = True;
        $num .= substr: 1;
    }

    my UInt $decimal    = 0;
    my UInt $multiplier = 1;

    for $num.split( '', :skip-empty ).reverse -> Str $digit
    {
        $decimal    += %DIG-VAL{ $digit } * $multiplier;
        $multiplier *= $base;
    }

    return $neg ?? -$decimal !! $decimal;
}

#-------------------------------------------------------------------------------
sub validate-data( Str:D $num, Base:D $base )
#-------------------------------------------------------------------------------
{
    my Str  @digits = @DIGITS[ 0 .. $base - 1 ];
    my Str  @num    = $num.split: '', :skip-empty;
    my UInt $start  = @num[ 0 ] eq '-' ?? 1 !! 0;

    for $start .. @num.end -> UInt $i
    {
        my Str $d = @num[ $i ];

        $d ∈ @digits or error( qq["$d" is not a valid digit for base $base] );
    }
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num, $base, $expected) = $line.split: '|';

        for     $test-name, $num, $base, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        validate-data( $num, $base.Int );

        my Int $decimal = convert-to-decimal( $num, $base.Int );

        is $decimal, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|101010| 2|        42
        Example 2|EEADEE|16|  15642094
        Example 3|   755| 8|       493
        Example 4| 1BRJB|36|   2228519
        Example 5| 7MyqL|64| 123456789
        Negative |-7MyqL|64|-123456789
        END
}

################################################################################
