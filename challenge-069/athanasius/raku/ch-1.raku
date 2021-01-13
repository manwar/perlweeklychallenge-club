use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#*******************************************************************************
=begin comment

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

=end comment
#*******************************************************************************

my UInt constant $MAX    = 1e15.UInt;                      # Maximum upper bound
my      constant %MIDDLE = 0 => 1, 1 => 8, 8 => Nil;
my      constant %OUTER  = 1 => 6, 6 => 8, 8 => 9, 9 => Nil;
my      constant %INNER  = 0 => 1, %OUTER;
my      constant %PAIRS  = 0 => 0, 1 => 1, 6 => 9, 8 => 8, 9 => 6;

subset Bound of UInt where 1 <= * <= $MAX;      # +ve integer in specified range

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    Bound:D $A,                           #= Lower bound (UInt: 1 <= A <= 10^15)
    Bound:D $B where { $A <= $B },        #= Upper bound (UInt: A <= B <= 10^15)
)
#===============================================================================
{
    "Challenge 069, Task #1: Strobogrammatic Number (Raku)\n".put;

    "Input:  A = $A, B = $B\nOutput: ".print;

    if (my UInt $number = first-strobogrammatic-number($A)) <= $B
    {
        $number.print;
        $number = next-strobogrammatic-number($number);

        while $number <= $B
        {
            ", $number".print;
            $number = next-strobogrammatic-number($number);
        }
    }

    ''.put;
}

#-------------------------------------------------------------------------------
sub first-strobogrammatic-number(UInt:D $min --> UInt:D)
#-------------------------------------------------------------------------------
{
    my UInt $size  =  $min.chars;
    my UInt $first = ($size == 1) ?? 1 !! ('1' ~ '0' x ($size - 2) ~ '1').UInt;

            $first =  next-strobogrammatic-number($first) while $first < $min;

    return  $first;
}

#-------------------------------------------------------------------------------
sub next-strobogrammatic-number(UInt:D $number --> UInt:D)
#-------------------------------------------------------------------------------
{
    my UInt @digits =  $number.split('', :skip-empty).map: { .UInt };
    my UInt $size   =  @digits.elems;
    my UInt $middle = ($size / 2).floor;

    return %MIDDLE{ @digits[0] } // 11 if $size == 1;     # single digit number

    if $size % 2 == 1                                     # odd number of digits
    {
        if (my $next = %MIDDLE{ @digits[$middle] }).defined
        {
            @digits[$middle] = $next;

            return @digits.join('').UInt;
        }

        @digits[$middle] = 0;
    }

    for (1 .. --$middle).reverse -> UInt $i
    {
        my UInt $j = $size - $i - 1;

        if (my $next = %INNER{ @digits[$i] }).defined
        {
            @digits[$i] = $next;
            @digits[$j] = %PAIRS{ $next };

            return @digits.join('').UInt;
        }

        @digits[$i] = @digits[$j] = 0;
    }

    if (my $next = %OUTER{ @digits[0] }).defined
    {
        @digits[  0] = $next;
        @digits[*-1] = %PAIRS{ $next };

        return @digits.join('').UInt;
    }

    @digits[  0] = 0;
    @digits[*-1] = 1;
    @digits.unshift: 1;

    return @digits.join('').UInt;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
