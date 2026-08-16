use v6d;

################################################################################
=begin comment

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
2. Two strings, each representing a non-negative rational number, are entered on
   the command-line.
3. If VERBOSE is set to True, the output ("true" or "false") is followed by a
   short explanation detailing how each input string has been interpreted as a
   rational number (in normalised form).

=end comment
#===============================================================================

use Test;

subset Result of List where (Bool, Rat, Rat);

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 386, Task #2: Rational Numbers (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $rat1,             #= First  non-negative rational number
    Str:D $rat2              #= Second non-negative rational number
)
#===============================================================================
{
    qq[Input:  \$rat1 = "$rat1"].put;
    qq[        \$rat2 = "$rat2"].put;

    my Result $result = are-equal( $rat1, $rat2 );

    "Output: %s\n".printf: $result[0] ?? 'true' !! 'false';

    if VERBOSE
    {
        my UInt $width = ($rat1.chars, $rat2.chars).max + 2;

        "\nExplanation:".put;
        qq[  %-*s = %d/%d\n].printf: $width, qq["$rat1"], $result[1].nude;
        qq[  %-*s = %d/%d\n].printf: $width, qq["$rat2"], $result[2].nude;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub are-equal( Str:D $rat1, Str:D $rat2 --> Result:D )
#-------------------------------------------------------------------------------
{
    my Rat $r1 = parse-rational( $rat1 );
    my Rat $r2 = parse-rational( $rat2 );

    return $r1 == $r2, $r1, $r2;
}

#-------------------------------------------------------------------------------
sub parse-rational( Str:D $str is copy --> Rat:D )
#-------------------------------------------------------------------------------
{
    $str .= substr: 1  if $str ~~ / ^  \+   /;      # Discard initial "+"
    $str  = '0' ~ $str if $str ~~ / ^  \. . /;      # Allow   initial "."
    $str ~= '0'        if $str ~~ / \d \. $ /;      # Allow  trailing "."

    my Rat $rat;

    try
    {
        $rat = $str.Rat;
    }

    if $!
    {
        $rat =  parse-repeating( $str );
        $rat // error( qq["$str" is not a valid rational number] );
    }

    error( qq["$str" is negative] ) if 0 > $rat;

    return $rat;
}

#-------------------------------------------------------------------------------
sub parse-repeating( Str:D $str --> Rat )
#-------------------------------------------------------------------------------
{
    my Rat $rat;

    if $str ~~ / ^ (\d+) \. (\d*) \( (\d+) \) $ /
    {
        my Str ($int, $fixed, $rep) = ~« @$/;

        my UInt $x     = ($int ~ $fixed).Int;
        my UInt $y     = ($x   ~ $rep  ).Int;
        my UInt $diff  =  $y   - $x;
        my UInt $mult1 =  10 **  $fixed.chars;
        my UInt $mult2 =  10 ** ($fixed.chars + $rep.chars);

        $rat = $diff / ($mult2 - $mult1);
    }

    return $rat;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $rat1, $rat2, $expected) = $line.split: '|';

        for     $test-name, $rat1, $rat2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Result $result = are-equal( $rat1, $rat2 );
        my Str    $equal  = $result[0] ?? 'true' !! 'false';

        is $equal, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "\nERROR: $message".put;

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
        Example 1| 0.(12)  | 0.(121)  |false
        Example 2| 0.1(23) | 0.12(32) |true
        Example 3| 0.1(234)| 0.12(342)|true
        Example 4|12.99(99)|13.       |true
        Example 5| 0.(123) | 0.1(231) |true
        END
}

################################################################################
