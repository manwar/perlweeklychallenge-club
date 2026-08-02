#!perl

################################################################################
=comment

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
2. A number and a base are entered on the command-line.

Assumptions
-----------
1. The input number to be converted is a signed integer.
2. The input base is an integer greater than 1.

Output
------
The symbol set comprises all the printable ASCII characters, with the exception
of '-' (minus, which is used to indicate negative numbers) and ' ' (space).
Hence, a number in any base up to 93 is represented as a string of ASCII char- acters; for example, the decimal number 1,234,567,890 is represented in base 93
by the string "Gk]Ap".

For bases 94 and above, a different notation is used: each digit is represented
by a decimal number, and the digits are separated by a special SEPARATOR char-
acter which may be, say, a space, or a non-ASCII character such as '·' (middle
dot); for example, 1,234,567,890 may be represented in base 94 by the string
"15·76·36·20·90".

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

# All ASCII printable characters except '-' (minus) and ' ' (space)

const my @BASE_ASCII =>
      '0' .. '9', 'A' .. 'Z', 'a' .. 'z',
      '`', qw( ~ ! @ ), '#', qw( $ % ^ & * ( ) _ = + [ { ] } \\ | ; : ' " ),
      ',', qw( < . > / ? );

const my $MAX_ASCII  => scalar @BASE_ASCII;
const my $SEPARATOR  => '·';
const my $USAGE      => <<END;
Usage:
  Usage:
  perl $0 <num> <base>
  perl $0

    <num>     An integer to be converted
    <base>    The new base
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 384, Task #1: Base N (Perl)\n\n";
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
        my  ($num, $base) = @ARGV;

        for ($num, $base)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        $base > 1                  or error( "$base is not a valid base" );

        print "Input:  \$num = $num, \$base = $base\n";

        my $converted = convert_to_base( $num, $base );

        print "Output: $converted\n";
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub convert_to_base
#-------------------------------------------------------------------------------
{
    my ($num, $base) = @_;

    / ^ $RE{num}{int} $ /x or die qq["$_" is not a valid integer]
        for $num, $base;

    $base > 1              or die "$base is not a valid base";

    my $converted = $num < 0 ? '-' : '';
    my $decimal   = abs $num;

    if ($base == 2 || $base == 8 || $base == 16)
    {
        $converted .= sprintf +($base == 2 ? '%b' :
                                $base == 8 ? '%o' : '%X'), $decimal;
    }
    else
    {
        my @powers;

        for (my $p = 1; $p <= $decimal; $p *= $base)
        {
            unshift @powers, $p;
        }

        my @digits;

        for my $power (@powers)
        {
            my $digit = int( $decimal / $power );
            $decimal -= $power * $digit;

            push @digits, $digit;
        }

        $converted .= ($base > $MAX_ASCII) ? join( $SEPARATOR, @digits ) :
                            join '', map { $BASE_ASCII[ $_ ] } @digits;
    }

    return $converted;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num, $base, @expected) = split / \| /x, $line;

        for ($test_name, $num, $base, @expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $converted = convert_to_base( $num, $base );
        my $expected  = join $SEPARATOR, @expected;

        is $converted, $expected, $test_name;
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
