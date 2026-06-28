use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 379
=========================

TASK #2
-------
*Armstrong Number*

Submitted by: Mohammad Sajid Anwar

You are given two integers, $base and $limit.

Write a script to find all Armstrong numbers in base $base that are less than
$limit.

  If raising each of the digits of a nonnegative integer to the power of the
  total number of digits, then taking the sum, equals the original number, it is
  an Armstrong number.

Example 1

  Input: $base = 10, $limit = 1000
  Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)

Example 2

  Input: $base = 7, $limit = 1000
  Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)

Example 3

  Input: $base = 16, $limit = 1000
  Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520,
  584, 645)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. $base is a positive integer greater than 1.
2. $base is no greater than 36. This is the maximum radix accepted by the Raku
   method parse-base(); it is the maximum base that can be represented by the
   digits 0 to 9 together with the letters A to Z.
3. $limit is an unsigned integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two unsigned integers, $base and $limit, are entered on the command-line.
   $base must be between 2 and 36, inclusive.
3. If desired, the command-line arguments are preceded by a "-s" flag to signal
   that the output (which is in decimal) is to be repeated in the given base.

Reference
---------
Wikipedia contributors. Narcissistic number [Internet]. Wikipedia, The Free
Encyclopedia; 2025 Sep 30, 19:38 UTC [cited 2026 Jun 24]. Available from:
https://en.wikipedia.org/w/index.php?title=Narcissistic_number&oldid=1314314515

=end comment
#===============================================================================

use Test;

my UInt constant MAX-BASE = 36;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 379, Task #2: Armstrong Number (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Number base of Armstrong numbers (from 2 to 36)

    UInt:D $base where MAX-BASE >= * > 1,
    UInt:D $limit,                           #= Upper limit of Armstrong numbers
    Bool:D :s(:$show-in-base) = False        #= Show output in the given $base?
)
#===============================================================================
{
    "Input:  \$base = $base, \$limit = $limit".put;

    my UInt @armstrong = find-armstrong-nums( $base, $limit );

    "Output: (%s)\n".printf: @armstrong.join: ', ';

    if $show-in-base && $base !== 10
    {
        "      = (%s) (base %d)\n".printf:
            @armstrong.map( { .base( $base ) } ).join( ', ' ), $base;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-armstrong-nums
(
    UInt:D $base where MAX-BASE >= * > 1,            #= Number base
    UInt:D $limit                                    #= Upper limit
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my UInt @armstrong;
    my UInt @powers =  0 ..^ $base;                  # Exponent 1
    my UInt $n      =  0;
    my UInt $end    = ($base, $limit).min;

    @armstrong.push: $n++ while $end > $n;

    loop (my UInt $exp = 2; $limit > $n; ++$exp)
    {
        @powers[ $_ ] *= $_ for 0 ..^ $base;         # Exponent 2+

        $end = ($base ** $exp, $limit).min;

        while $end > ++$n
        {
            my UInt @digits = ($base == 10)
                    ??               $n.split( '', :skip-empty ).map: { .Int }
                    !! $n.base( $base ).split( '', :skip-empty )
                                       .map: { .parse-base( $base ) };

            my UInt $sum = [+] @powers[ @digits ];

            @armstrong.push: $n if $n == $sum;
        }
    }

    return @armstrong;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $base, $limit, $exp-str) = $line.split: '|';

        for     $test-name, $base, $limit, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @armstrong = find-armstrong-nums( $base.Int, $limit.Int );
        my UInt @expected  = $exp-str.split( / \s+ /, :skip-empty )
                                     .map: { .Int };

        is-deeply @armstrong, @expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|10|1000|0 1 2 3 4 5 6 7 8 9 153 370 371 407
        Example 2| 7|1000|0 1 2 3 4 5 6 10 25 32 45 133 134 152 250
        Example 3|16|1000|0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 342 371 520    \
                          584 645
        Base 12  |12|2700|0 1 2 3 4 5 6 7 8 9 10 11 29 125 811 944 1539
        Base 36  |36|5500|0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 \
                          21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 5489
        END

    return S:g/ \s+ \\ \n \s* / / given $data;
}

################################################################################
