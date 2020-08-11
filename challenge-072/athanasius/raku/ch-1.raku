use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 072
=========================

Task #1
-------
*Trailing Zeroes*

*Submitted by:* Mohammad S Anwar

You are given a positive integer $N (<= 10).

Write a script to print number of trailing zeroes in $N!.

*Example 1*

Input: $N = 10
Output: 2 as $N! = 3628800 has 2 trailing zeroes

*Example 2*

Input: $N = 7
Output: 1 as $N! = 5040 has 1 trailing zero

*Example 3*

Input: $N = 4
Output: 0 as $N! = 24 has 0 trailing zero

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

The simplest solution to the problem *as given* (i.e., with only 11 possible
cases, from 0! to 10!) is a lookup table, in which the answers are pre-computed.

The more interesting problem is to find the number of trailing zeroes for a
factorial n! of arbitrary size n. Since each trailing zero results from a factor
pair of 2 and 5 -- and since the number of factors of 2 is always larger than the
corresponding number of factors of 5 -- this means simply counting the number of
times 5 occurs as a factor in the numbers 1 .. n. Care must be taken when
considering powers of 5; e.g., 24! has 4 trailing zeroes, but 25! has 6 (an
additional 2 zeroes) because 25 = 5 * 5.

In the solution code below, the command-line flag "--ext[ended]" allows values
of n greater than 10 to be given as input; e.g.:

    18:25 >raku ch-1.raku --ext 25

    Challenge 072, Task #1: Trailing Zeroes (Raku)

    Input:  N = 25
    Output: 6 (because 25! has 6 trailing zeroes)

    18:25 >

=end comment
#===============================================================================

my UInt constant $MAX-N  = 10;
my      constant @ZEROES =  #        N! #0s        N
                            (         1, 0 ),   #  0
                            (         1, 0 ),   #  1
                            (         2, 0 ),   #  2
                            (         6, 0 ),   #  3
                            (        24, 0 ),   #  4
                            (       120, 1 ),   #  5
                            (       720, 1 ),   #  6
                            (     5_040, 1 ),   #  7
                            (    40_320, 1 ),   #  8
                            (   362_880, 1 ),   #  9
                            ( 3_628_800, 2 );   # 10

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 072, Task #1: Trailing Zeroes (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    UInt:D $N,                                   #= A positive integer <= $MAX-N
    Bool:D :ext(:$extended) = False,             #= Allow values of N  >  $MAX-N
)
#===============================================================================
{
    if $N > $MAX-N && !$extended
    {
        USAGE();
        exit(1);
    }

    "Input:  N = %d\n".printf: $N;

    my UInt ($zeroes, $factorial);

    if $N > $MAX-N
    {
        $zeroes = find-trailing-zeroes($N);
    }
    else
    {
       ($factorial, $zeroes) = @ZEROES[ $N ];
    }

    "Output: %d (because %d!%s has %d trailing zero%s)\n".printf:
        $zeroes, $N, $factorial ?? sprintf(' = %d', $factorial) !! '', $zeroes,
        $zeroes == 1 ?? '' !! 'es';
}

#-------------------------------------------------------------------------------
sub find-trailing-zeroes(UInt:D $n --> UInt:D)
#-------------------------------------------------------------------------------
{
    # Adapted from Rahul Jain, "Count trailing zeroes in factorial of a number":
    #     https://www.geeksforgeeks.org/count-trailing-zeroes-factorial-number/

    my UInt $count = 0; 
  
    loop (my UInt $i = 5; $n / $i >= 1; $i *= 5)
    {
        $count += floor($n / $i); 
    }
  
    return $count; 
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s  / ($*PROGRAM-NAME) /raku $0/;
    $usage ~~ s:g/ \$MAX\-N         /$MAX-N/;
    $usage.put;
}

################################################################################
