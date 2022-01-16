#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $TARGET => 20;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 147, Task #1: Truncatable Prime (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die "ERROR: Expected 0 command line arguments, found " .
                         "$args\n$USAGE";

    my @ltps  = (2, 5);
    my @bases = (3, 7);
    my $count = scalar @ltps + scalar @bases;

    while ($count < $TARGET && scalar @bases > 0)
    {
        my @new;

        OUTER_FOR:
        for my $i (1 .. 9)
        {
            for my $base (@bases)
            {
                my $p = $i . $base;

                if (is_prime( $p ))
                {
                    push @new, $p;
                    last OUTER_FOR unless ++$count < $TARGET;
                }
            }
        }

        push @ltps, @bases;
        @bases = @new;
    }

    printf "The first %d left-truncatable prime numbers in base 10:\n%s\n",
            $TARGET, join ', ', sort { $a <=> $b } @ltps, @bases;
}

#------------------------------------------------------------------------------
sub is_prime
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    for my $i (2 .. int sqrt $n)
    {
        return 0 if $n % $i == 0;
    }

    return 1;
}

###############################################################################
