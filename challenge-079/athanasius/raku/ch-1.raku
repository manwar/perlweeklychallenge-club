use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 079
=========================

Task #1
-------
*Count Set Bits*

Submitted by: Mohammad S Anwar

You are given a positive number $N.

Write a script to count the total numbrer of set bits of the binary representa-
tions of all numbers from 1 to $N and return $total_count_set_bit % 1000000007.

Example 1:

 Input: $N = 4

 Explanation: First find out the set bit counts of all numbers i.e. 1, 2, 3 and
 4.

     Decimal: 1
     Binary: 001
     Set Bit Counts: 1

     Decimal: 2
     Binary: 010
     Set Bit Counts: 1

     Decimal: 3
     Binary: 011
     Set Bit Counts: 2

     Decimal: 4
     Binary: 100
     Set Bit Counts: 1

     Total set bit count: 1 + 1 + 2 + 1 = 5

 Output: Your script should print `5` as `5 % 1000000007 = 5`.

Example 2:

 Input: $N = 3

 Explanation: First find out the set bit counts of all numbers i.e. 1, 2 and 3.

     Decimal: 1
     Binary: 01
     Set Bit Count: 1

     Decimal: 2
     Binary: 10
     Set Bit Count: 1

     Decimal: 3
     Binary: 11
     Set Bit Count: 2

     Total set bit count: 1 + 1 + 2 = 4

 Output: Your script should print `4` as `4 % 1000000007 = 4`.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
The set bit count sums for numbers 0, 1, 2, ... are given by the sequence
"A000788  Total number of 1's in binary expansions of 0, ..., n." in "The On-
Line Encyclopedia of Integer Sequences" [ https://oeis.org/A000788 ].

The first 63 terms (i.e., for n = 0 to 62) are:
0, 1, 2, 4, 5, 7, 9, 12, 13, 15, 17, 20, 22, 25, 28, 32, 33, 35, 37, 40, 42,
45, 48, 52, 54, 57, 60, 64, 67, 71, 75, 80, 81, 83, 85, 88, 90, 93, 96, 100,
102, 105, 108, 112, 115, 119, 123, 128, 130, 133, 136, 140, 143, 147, 151, 156,
159, 163, 167, 172, 176, 181, 186.

Additional terms up to n = 10000 are given in the file "b000788.txt"
[ https://oeis.org/A000788/b000788.txt ]. Some examples (useful for testing):

        ---------------------
             n     A000788(n)
        ---------------------
             252     1,002
           1,879    10,004
           6,494    40,007
          10,000    64,613
        ---------------------

=end comment
#==============================================================================

my UInt constant $MODULUS = 1_000_000_007;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 079, Task #1: Count Set Bits (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    UInt:D $N                   #= A positive integer
)
##=============================================================================
{
    "Input:  \$N = $N".put;

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Code adapted from:
    #     David W. Wilson, "Fast C++ function for computing a(n)",
    #                       https://oeis.org/A000788/a000788.txt
    #
    # unsigned A000788(unsigned n)
    # {
    #     unsigned v = 0;
    #     for (unsigned bit = 1; bit <= n; bit <<= 1)
    #        v += ((n>>1)&~(bit-1)) + ((n&bit) ? (n&((bit<<1)-1))-(bit-1) : 0);
    #     return v;
    # }
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    my UInt $total-count-set-bit = 0;

    loop (my UInt $bit = 1; $bit <= $N; $bit +<= 1)
    {
        $total-count-set-bit += ($N +> 1) +& +^($bit - 1);

        $total-count-set-bit += ($N +& (($bit +< 1) - 1)) - ($bit - 1)
            if $N +& $bit;
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    "Output: \$total-count-set-bit %% %d = %d\n".printf: $MODULUS,
              $total-count-set-bit % $MODULUS;
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
