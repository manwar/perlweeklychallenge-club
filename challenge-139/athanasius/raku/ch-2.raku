use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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
by changing the constants $TARGET and $VERBOSE:
 - $TARGET specifies the number of long primes to generate. (On my Core2 Duo
   2.16GHz machine, and with $VERBOSE set to a false value, the first 250 long
   primes are found and displayed in just over 15 seconds.)
 - If set to a true value (the default), $VERBOSE displays each long prime
   together with its reciprocal; the repeating digits in the reciprocal are
   enclosed in parentheses;
 - Set $TIMER to True to display the time elapsed.

Implementation
--------------
Primes are identified by Raku's in-built is-prime() method.

The non-repeating and repeating parts of a rational number's decimal expansion
are found by Raku's in-built base-repeating() method.

=end comment
#==============================================================================

my UInt constant $TARGET  = 5;
my Bool constant $VERBOSE = True;
my Bool constant $TIMER   = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 139, Task #2: Long Primes (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Instant $t0 = now if $TIMER;

    "The first $TARGET long primes:".print;

    my Bool $first = True;
    my UInt $n     = 2;

    loop (my UInt $count = 0; $count < $TARGET; ++$n)
    {
        if $n.is-prime
        {
            my Rat  $reciprocal = Rat.new: 1, $n;
            my Str ($non-rep, $repeating) = $reciprocal.base-repeating: 10;

            if $repeating.chars == $n - 1
            {
                if $VERBOSE
                {
                    "\n\n".print if $first;

                    "  %2d  because 1/%2d = %s\(%s)\n".printf:
                        $n, $n, $non-rep, $repeating;
                }
                else
                {
                    "%s%d".printf: ($first ?? ' ' !! ', '), $n;
                }

                $first = False;
                ++$count;
            }
        }
    }

    "\n".print unless $VERBOSE;
    "\n{now - $t0} seconds".put if $TIMER;
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
