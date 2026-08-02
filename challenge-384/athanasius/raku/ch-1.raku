use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 384
=========================

TASK #1
-------
*Base N*

Submitted by: Mohammad Sajid Anwar

You are given a number and a base integer.

Write a script to convert the given number in the given base integer.

Example 1

  Input: $num = 42, $base = 2
  Output: 101010

Example 2

  Input: $num = 15642094, $base = 16
  Output: EEADEE

Example 3

  Input: $num = 493, $base = 8
  Output: 755

Example 4

  Input: $num = 2228519, $base = 36
  Output: 1BRJB

  Base 36 uses numbers 0-9 and letters A-Z.

Example 5

  Input: $num = 123456789, $base = 64
  Output: 7MyqL

  Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)

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
2. A number and a base are entered on the command-line.
3. If the first number is negative, it must be preceded by "--" to indicate that
   it is not a command-line flag.

Assumptions
-----------
1. The input number to be converted is a signed integer.
2. The input base is an integer greater than 1.

Output
------
The symbol set comprises all the printable ASCII characters, with the exception
of '-' (minus, which is used to indicate negative numbers) and ' ' (space).
Hence, a number in any base up to 93 is represented as a string of ASCII char-
 acters; for example, the decimal number 1,234,567,890 is represented in base 93
by the string "Gk]Ap".

For bases 94 and above, a different notation is used: each digit is represented
by a decimal number, and the digits are separated by a special SEPARATOR char-
acter which may be, say, a space, or a non-ASCII character such as '·' (middle
dot); for example, 1,234,567,890 may be represented in base 94 by the string
"15·76·36·20·90".

=end comment
#===============================================================================

use Test;

# All ASCII printable characters except '-' (minus) and ' ' (space)

my constant @BASE-ASCII = Array[Str].new:
   |('0' .. '9'), |('A' .. 'Z'), |('a' .. 'z'),
   |< ` ~ ! @ # $ % ^ & * ( ) _ = + [ { ] } \\ | ; : ' " , \< . \> / ? >;

my UInt constant MAX-NATIVE = 36;
my UInt constant MAX-ASCII  = @BASE-ASCII.elems;
my Str  constant SEPARATOR  = '·';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 384, Task #1: Base N (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D  $num,                       #= An integer to be converted
    UInt:D $base where * > 1           #= The new base
)
#===============================================================================
{
    "Input:  \$num = $num, \$base = $base".put;

    my Str $converted = convert-to-base( $num, $base );

    "Output: $converted".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub convert-to-base( Int:D $num, UInt:D $base where * > 1 --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $converted = '';

    if MAX-NATIVE >= $base
    {
        $converted = $num.base: $base;
    }
    else
    {
        $converted = '-' if 0 > $num;

        my Int  $decimal = $num.abs;
        my UInt @powers  = +«( 1, $base, $base² …^ * > $decimal ).reverse;
        my UInt @digits;

        for @powers -> UInt $power
        {
            my UInt $digit = ($decimal / $power).floor;

            @digits.push: $digit;
            $decimal -= $power * $digit;
        }

        $converted ~= (MAX-ASCII >= $base)
                       ?? @digits.map( { @BASE-ASCII[ $_ ] } ).join
                       !! @digits.join: SEPARATOR;
    }

    return $converted;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num, $base,  @expected) = $line.split: '|';

        for     $test-name, $num, $base, |@expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $converted = convert-to-base( $num.Int, $base.Int );
        my Str $expected  = @expected.join: SEPARATOR;

        is $converted, $expected, $test-name;
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
        Example 1  |        42|  2| 101010
        Example 2  |  15642094| 16| EEADEE
        Example 3  |       493|  8|    755
        Example 4  |   2228519| 36|  1BRJB
        Example 5  | 123456789| 64|  7MyqL
        Negative   |-123456789| 64| -7MyqL
        Large base |1234567890| 93|  Gk]Ap
        Binary     |        65|  2|1000001
        Octal      |       -65|  8|   -101
        Hexadecimal|       127| 16|     7F
        Wide digits|9753124680|101|93|73|28|96|90
        END
}

################################################################################
