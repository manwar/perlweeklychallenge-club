use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 157
=========================

TASK #1
-------
*Pythagorean Means*

Submitted by: Mohammad S Anwar

You are given a set of integers.

Write a script to compute all three Pythagorean Means i.e Arithmetic Mean,
Geometric Mean and Harmonic Mean of the given set of integers. Please refer to
wikipedia [ https://en.wikipedia.org/wiki/Pythagorean_means |page] for more 
informations.

Example 1:

  Input: @n = (1,3,5,6,9)
  Output: AM = 4.8, GM = 3.8, HM = 2.8

CORRECTION [2022-03-21 16:35] GM = 3.9 (before)

Example 2:

  Input: @n = (2,4,6,8,10)
  Output: AM = 6.0, GM = 5.2, HM = 4.4

Example 3:

  Input: @n = (1,2,3,4,5)
  Output: AM = 3.0, GM = 2.6, HM = 2.2

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
The number of decimal places in the three output means may be adjusted via the
$DECIMALS constant. This defaults to 1, as per the Examples.

Algorithm
---------
For a given set of integers S = { x_1, x_2, ..., x_n }, with cardinal number n:
  - the arithmetic mean =     (   x_1 + ... +   x_n ) / n
  - the geometric  mean = nth√|   x_1 * ... *   x_n |
  - the harmonic   mean = n / ( 1/x_1 + ... + 1/x_n )

Implementation
--------------
Note that Raku's reduction metaoperators provide a succinct and elegant syntax
for summation and multiplication. For example, the Perl code for calculating
the arithmetic mean:

    my $sum  = 0;
       $sum += $_ for @n;
    my $am   = $sum / $n;

can be reduced to a single line in Raku:

    my Real $am = ([+] @n) / $n;

=end comment
#==============================================================================

my UInt constant $DECIMALS = 1;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 157, Task #1: Pythagorean Means (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    **@n where { .all ~~ Int:D }                           #= A set of integers
)
#==============================================================================
{
    "Input:  @n = (%s)\n".printf: @n.join: ', ';

    my UInt $n  = +@n;                                     # Cardinal number
    my Real $am = ([+] @n) / $n;                           # Arithmetic mean
    my Real $gm = ([*] @n).abs ** (1 / $n);                # Geometric  mean
    my Real $hm = $n / ([+] @n.map: { 1 / $_ });           # Harmonic   mean

    "Output: AM = %.*f, GM = %.*f, HM = %.*f\n".printf:
        $DECIMALS, $am,
        $DECIMALS, $gm,
        $DECIMALS, $hm;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
