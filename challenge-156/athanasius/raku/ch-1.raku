use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 156
=========================

TASK #1
-------
*Pernicious Numbers*

Submitted by: Mohammad S Anwar

Write a script to permute first 10 Pernicious Numbers.

    A pernicious number is a positive integer which has prime number of ones in
    its binary representation.

The first pernicious number is 3 since binary representation of 3 = (11) and
1 + 1 = 2, which is a prime.

Expected Output

  3, 5, 6, 7, 9, 10, 11, 12, 13, 14

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Although the Task specifies a target of 10, I have extended the solution to
accept any target integer value greater than 0; but if no argument is supplied
on the command line, the target defaults to 10.

Table
-----
The first 100 Pernicious Numbers [1, 2]:

      3,   5,   6,   7,   9,  10,  11,  12,  13,  14,
     17,  18,  19,  20,  21,  22,  24,  25,  26,  28,
     31,  33,  34,  35,  36,  37,  38,  40,  41,  42,
     44,  47,  48,  49,  50,  52,  55,  56,  59,  61,
     62,  65,  66,  67,  68,  69,  70,  72,  73,  74,
     76,  79,  80,  81,  82,  84,  87,  88,  91,  93,
     94,  96,  97,  98, 100, 103, 104, 107, 109, 110,
    112, 115, 117, 118, 121, 122, 124, 127, 129, 130,
    131, 132, 133, 134, 136, 137, 138, 140, 143, 144,
    145, 146, 148, 151, 152, 155, 157, 158, 160, 161

Algorithm
---------
The natural numbers, in ascending order, are filtered as follows:
 - each natural number n is converted to its binary representation b;
 - the 1-digits in b are counted;
 - if the count is a primary number, n is recorded as a pernicious number.
 - the filtering process continues until the number of pernicious numbers found
   is equal to the given target.

References
----------
[1] "A052294  Pernicious numbers: numbers with a prime number of 1's in their
     binary expansion.", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A052294
[2]  Iain Fox, "Table of n, a(n) for n = 1..10000",
     https://oeis.org/A052294/b052294.txt
[3] "Pernicious number", Wikipedia,
     https://en.wikipedia.org/wiki/Pernicious_number

=end comment
#==============================================================================

my UInt constant $TARGET = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 156, Task #1: Pernicious Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $target where * > 0 = $TARGET            #= The required output size
)
#==============================================================================
{
    "The first $target Pernicious Numbers:".put;

    my UInt @pernicious;

    loop (my UInt $n = 1; +@pernicious < $target; ++$n)
    {
        my Str  $bin  = '%b'.sprintf: $n;           # Convert to binary
        my UInt $ones = +$bin.comb: '1';            # Count the ones

        @pernicious.push: $n if $ones.is-prime;
    }

    "%s\n".printf: @pernicious.join: ', ';
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
