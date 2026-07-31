use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 383
=========================

TASK #2
-------
*Nearest RGB*

Submitted by: Mohammad Sajid Anwar

You are given a 6-digit hex color.

Write a script to round the RGB channels to the nearest web-safe value and
return the nearest RGB color.

  00 (0), 33 (51), 66 (102), 99 (153), CC (204) and FF (255)

Example 1

  Input: $color = "#F4B2D1"
  Output: "#FF99CC"

  Red: F4 (Decimal 244), closer to 255 => FF
  Green: B2 (Decimal 178), closer to 153 => 99
  Blue: D1 (Decimal 209), closer to 204 => CC
  So the nearest RGB: "#FF99CC"

Example 2

  Input: $color = "#15E6E5"
  Output: "#00FFCC"

  Red: 15 (Decimal 21), closer to 0 => 00
  Green: E6 (Decimal 230), closer to 255 => FF
  Blue: E5 (Decimal 229), closer to 204 => CC

Example 3

  Input: $color = "#191A65"
  Output: "#003366"

  Red: 19 (Decimal 25), closer to 0 => 00
  Green: 1A (Decimal 26), closer to 51 => 33
  Blue: 65 (Decimal 101), closer to 102 => 66

Example 4

  Input: $color = "#2D5A1B"
  Output: "#336633"

  Red: 2D (Decimal 45), closer to 51 => 33
  Green: 5A (Decimal 90), closer to 102 => 66
  Blue: 1B (Decimal 27), closer to 51 => 33

Example 5

  Input: $color = "#00FF66"
  Output: "#00FF66"

  Red: 00 (Decimal 0), closer to 0 => 00
  Green: FF (Decimal 255), closer to 255 => FF
  Blue: 66 (Decimal 102), closer to 102 => 66

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
2. A 6-digit hexadecimal colour with prefix "#" is entered on the command-line.

Assumption
----------
The "#" prefix is required on RGB hex colours.

=end comment
#===============================================================================

use Test;

subset HexColour of Str where m:i/ ^ [\#] <xdigit> ** 6 $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 383, Task #2: Nearest RGB (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    HexColour:D $colour         #= A 6-digit hex colour preceded by "#"
)
#===============================================================================
{
    qq[Input:  \$colour  = "$colour"].put;

    my HexColour $websafe = find-nearest-RGB( $colour );

    qq[Output: Web-safe = "$websafe"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-nearest-RGB( HexColour:D $colour --> HexColour:D )
#-------------------------------------------------------------------------------
{
    $colour ~~ m:i/ ^ [\#] (<xdigit> ** 2) (<xdigit> ** 2) (<xdigit> ** 2) $ /;

    my UInt $red   = :16( ~$0 );
    my UInt $green = :16( ~$1 );
    my UInt $blue  = :16( ~$2 );
    my Str  $safe  = '#';

    for $red, $green, $blue -> UInt $original
    {
        my $new = $original >= 230 ?? 255 !!
                  $original >= 179 ?? 204 !!
                  $original >= 128 ?? 153 !!
                  $original >=  77 ?? 102 !!
                  $original >=  26 ??  51 !! 0;

        $safe ~= '%02X'.sprintf: $new;
    }

    return $safe;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $colour, $expected) = $line.split: '|';

        for     $test-name, $colour, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my HexColour $websafe = find-nearest-RGB( $colour );

        is $websafe, $expected, $test-name;
    }

    done-testing;
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
        Example 1|#F4B2D1|#FF99CC
        Example 2|#15E6E5|#00FFCC
        Example 3|#191A65|#003366
        Example 4|#2D5A1B|#336633
        Example 5|#00FF66|#00FF66
        END
}

################################################################################
