#!perl

################################################################################
=comment

Perl Weekly Challenge 069
=========================

Task #1
-------
*Strobogrammatic Number*

*Submitted by:* Mohammad S Anwar

A strobogrammatic number is a number that looks the same when looked at upside
down.

You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.

Write a script to print all strobogrammatic numbers between the given two
numbers.

*Example*

 Input: $A = 50, $B = 100
     Output: 69, 88, 96

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#*******************************************************************************
=comment

"When written using standard characters (ASCII), the numbers, 0, 1, 8 are sym-
metrical around the horizontal axis, and 6 and 9 are the same as each other when
rotated 180 degrees. In such a system, the first few strobogrammatic numbers
are:

0, 1, 8, 11, 69, 88, 96, 101, 111, 181, 609, 619, 689, 808, 818, 888, 906, 916,
986, 1001, 1111, 1691, 1881, 1961, 6009, 6119, 6699, 6889, 6969, 8008, 8118,
8698, 8888, 8968, 9006, 9116, 9696, 9886, 9966, ... (sequence A000787 in the
OEIS)"

-- from https://en.wikipedia.org/wiki/Strobogrammatic_number

See also https://oeis.org/A000787 and
         https://oeis.org/A000787/b000787.txt

=cut
#*******************************************************************************

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $MAX   => 1e15;
const my $USAGE =>
"Usage:
  perl $0 <A> <B>

    <A>    Lower bound (UInt: 1 <= A <= 10^15)
    <B>    Upper bound (UInt: A <= B <= 10^15)\n";

const my %MIDDLE => (0 => 1, 1 => 8, 8 => undef);
const my %OUTER  => (1 => 6, 6 => 8, 8 => 9, 9 => undef);
const my %INNER  => (0 => 1), %OUTER;
const my %PAIRS  => (0 => 0, 1 => 1, 6 => 9, 8 => 8, 9 => 6);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 069, Task #1: Strobogrammatic Number (Perl)\n\n";

    my ($A, $B) = parse_command_line();

    print "Input:  A = $A, B = $B\nOutput: ";

    if ((my $number = first_strobogrammatic_number($A)) <= $B)
    {
        print $number;
        $number = next_strobogrammatic_number($number);

        while ($number <= $B)
        {
            print ", $number";
            $number = next_strobogrammatic_number($number);
        }
    }

    print "\n";
}

#-------------------------------------------------------------------------------
sub first_strobogrammatic_number
#-------------------------------------------------------------------------------
{
    my ($min)  =  @_;
    my  $size  =  length $min;
    my  $first = ($size == 1) ? 1 : '1' . '0' x ($size - 2) . '1';

        $first =  next_strobogrammatic_number($first) while $first < $min;

    return $first;
}

#-------------------------------------------------------------------------------
sub next_strobogrammatic_number
#-------------------------------------------------------------------------------
{
    my ($number) = @_;
    my  @digits  = split //, $number;
    my  $size    = scalar @digits;
    my  $middle  = int($size / 2);

    return $MIDDLE{ $digits[0] } // 11 if $size == 1;     # single digit number

    if ($size % 2 == 1)                                   # odd number of digits
    {
        if (defined(my $next = $MIDDLE{ $digits[$middle] }))
        {
            $digits[$middle] = $next;

            return join('', @digits);
        }

        $digits[$middle] = 0;
    }

    for my $i (reverse 1 .. --$middle)
    {
        my $j = $size - $i - 1;

        if (defined(my $next = $INNER{ $digits[$i] }))
        {
            $digits[$i] = $next;
            $digits[$j] = $PAIRS{ $next };

            return join('', @digits);
        }

        $digits[$i] = $digits[$j] = 0;
    }

    if (defined(my $next = $OUTER{ $digits[0] }))
    {
        $digits[ 0] = $next;
        $digits[-1] = $PAIRS{ $next };

        return join('', @digits);
    }

    $digits[ 0] = 0;
    $digits[-1] = 1;
    unshift @digits, 1;

    return join('', @digits);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 2                            or die $USAGE;

    my ($A, $B) = @ARGV;

    /\A$RE{num}{int}\z/ && 1 <= $_ && $_ <= $MAX or die $USAGE for $A, $B;

    $A <= $B                                     or die $USAGE;

    return ($A, $B);
}

################################################################################
