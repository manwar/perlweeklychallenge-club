#!perl

###############################################################################
=comment

Perl Weekly Challenge 139
=========================

TASK #2
-------
*Long Primes*

Submitted by: Mohammad S Anwar

Write a script to generate first 5 Long Primes.

    A prime number (p) is called Long Prime if (1/p) has an infinite decimal
    expansion repeating every (p-1) digits.

Example

  7 is a long prime since 1/7 = 0.142857142857...
  The repeating part (142857) size is 6 i.e. one less than the prime number 7.

  Also 17 is a long prime since 1/17 = 0.05882352941176470588235294117647...
  The repeating part (0588235294117647) size is 16 i.e. one less than the prime
  number 17.

  Another example, 2 is not a long prime as 1/2 = 0.5.
  There is no repeating part in this case.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Reference
---------
The Online Encyclopedia of Integer Sequences: "A001913. Full reptend primes:
primes with primitive root 10." at https://oeis.org/A001913:

  7,  17,  19,  23,  29,  47,  59,  61,  97, 109, 113, 131, 149, 167, 179, 181,
193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461,
487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743,
811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983 

Interface
---------
No command-line arguments are provided, but the script output may be altered
by changing the constants $TARGET, $VERBOSE, and TIMER:
 - $TARGET specifies the number of long primes to generate. (On my Core2 Duo
   2.16GHz machine, and with $VERBOSE set to a false value, the first 500 long
   primes are found and displayed in under 11 seconds.)
 - If set to a true value (the default), $VERBOSE displays each long prime
   together with its reciprocal; the repeating digits in the reciprocal are
   enclosed in parentheses;
 - Set TIMER to a true value to display the time elapsed.

Implementation
--------------
Primes are identified by the is_prime() routine from the CPAN module Math::
Prime::Util.

The non-repeating and repeating parts of a rational number's decimal expansion
are found by the base_repeating() routine ported from the source code for
Raku's Rational role.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( is_prime );

use constant TIMER => 0;

const my $TARGET   => 5;
const my $VERBOSE  => 1;
const my $USAGE    => "Usage:  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 139, Task #2: Long Primes (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );
    my $t0   = [gettimeofday] if TIMER;

    my $args = scalar @ARGV;
       $args == 0
        or die "ERROR: Expected 0 command line arguments, found $args\n$USAGE";

    print "The first $TARGET long primes:";

    for (my ($n, $first, $count) = (2, 1, 0); $count < $TARGET; ++$n)
    {
        if (is_prime( $n ))
        {
            my ($non_rep, $repeating) = base_repeating( $n );

            if (length $repeating == $n - 1)
            {
                if ($VERBOSE)
                {
                    printf "%s  %2d  because 1/%2d = %s(%s)\n",
                          ($first ? "\n\n" : ''), $n, $n, $non_rep, $repeating;
                }
                else
                {
                    printf "%s%d", ($first ? ' ' : ', '), $n;
                }

                $first = 0;
                ++$count;
            }
        }
    }

    print "\n" unless $VERBOSE;
    print "\n", tv_interval($t0), " seconds\n" if TIMER;
}

#------------------------------------------------------------------------------
# Ported from Raku (rakudo-2021.10/src/core.c/Rational.pm6) but simplified for
# this task as follows:
#  - the denominator is assumed to be a positive integer;
#  - the numerator is not passed in, because it is always 1;
#  - base 10 only is used because the task description specifies a *decimal*
#    expansion.
#
sub base_repeating
#------------------------------------------------------------------------------
{
    my ($denominator) = @_;                           # Must be an integer >= 1
    my  @quotients    = 0;
    my  $numerator    = 1;
    my (@remainders, %remainders, @cycle);

    while (1)
    {
        push @remainders, $numerator %= $denominator;

        last if $remainders{ $numerator }++ || $numerator == 0;

        $numerator *= 10;

        push @quotients, int( $numerator / $denominator );
    }

    if ($numerator > 0)
    {
        my $idx = 0;

        for my $remainder (@remainders)
        {
            last if $remainder == $numerator;
            ++$idx;
        }

        @cycle = splice @quotients, $idx + 1;
    }

    splice @quotients, 1, 0, '.';

    return (join( '', @quotients ), join( '', @cycle ));
}

###############################################################################
