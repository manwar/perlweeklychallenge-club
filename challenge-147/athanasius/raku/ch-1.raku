use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 147
=========================

TASK #1
-------
*Truncatable Prime*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 left-truncatable prime numbers in base 10.

    In number theory, a left-truncatable prime is a prime number which, in a
    given base, contains no 0, and if the leading left digit is successively
    removed, then all resulting numbers are primes.

Example

 9137 is one such left-truncatable prime since 9137, 137, 37 and 7 are all
 prime numbers.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
The smallest left-truncatable primes [1] (hereafter LTPs) are the single-digit
primes: 2, 3, 5, and 7. For all positive integers of 2 or more digits, we con-
sider the last (i.e., the least significant) digit:
  - 0 digits are not allowed;
  - numbers ending in 1, 4, 6, 8, or 9 are not prime when left-truncated to a
    single digit (note: 1 is neither prime nor composite);
  - numbers ending in 2 or 5 are divisible by 2 or 5, respectively, and so are
    composite.
Therefore, all LTPs of 2 or more digits must end in either 3 or 7.

The algorithm *constructs* a longer LTP by adding a single digit to the left of
a shorter, already-known LTP (for convenience, I call this a "base"). If the
result of this concatenation is itself a prime number, the constructed number
is a new LTP. The algorithm proceeds until either the required number of LTPs
have been found, or there are no more bases available on which to build. [2]

References
----------
[1] The Online Encyclopedia of Integer Sequences (https://oeis.org/A024785):
    "A024785  Left-truncatable primes: every suffix is prime and no digits are
     zero.
                2,   3,   5,   7,   13,  17,  23,  37,  43,  47,
               53,  67,  73,  83,   97, 113, 137, 167, 173, 197,
              223, 283, 313, 317,  337, 347, 353, 367, 373, 383,
              397, 443, 467, 523,  547, 613, 617, 643, 647, 653,
              673, 683, 743, 773,  797, 823, 853, 883, 937, 947,
              953, 967, 983, 997, 1223"

[2] From the COMMENTS section in [1]:
    "Last term is a(4260) = 357686312646216567629137"

=end comment
#==============================================================================

my UInt constant $TARGET = 20;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 147, Task #1: Truncatable Prime (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @ltps  = 2, 5;
    my UInt @bases = 3, 7;
    my UInt $count = @ltps.elems + @bases.elems;

    while $count < $TARGET && @bases.elems > 0
    {
        my UInt @new;

        OUTER-FOR:
        for 1 .. 9 -> UInt $i
        {
            for @bases -> UInt $base
            {
                my UInt $p = ($i ~ $base).Int;

                if $p.is-prime
                {
                    @new.push: $p;
                    last OUTER-FOR unless ++$count < $TARGET;
                }
            }
        }

        @ltps.push: |@bases;
        @bases = @new;
    }

    "The first %d left-truncatable prime numbers in base 10:\n%s\n".printf:
        $TARGET, (|@ltps, |@bases).sort.join: ', ';
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
