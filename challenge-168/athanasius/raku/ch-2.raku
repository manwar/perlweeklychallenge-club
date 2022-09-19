use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 168
=========================

TASK #2
-------
*Home Prime*

Submitted by: Mohammad S Anwar

You are given an integer greater than 1.

Write a script to find the home prime of the given number.

In number theory, the home prime HP(n) of an integer n greater than 1 is the
prime number obtained by repeatedly factoring the increasing concatenation of
prime factors including repetitions.

Further information can be found on [ https://en.wikipedia.org/wiki/Home_prime
|Wikipedia] and [ https://oeis.org/A037274 |OEIS].

Example

As given in the Wikipedia page,

  HP(10) = 773, as
   10 factors as 2×5 yielding HP10(1)                                =  25,
   25 factors as 5×5 yielding HP10(2) = HP25(1)                      =  55,
   55          = 5×11 implies HP10(3) = HP25(2) = HP55(1)            = 511, and
  511          = 7×73 gives   HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773,
                                                                a prime number.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If the constant $VERBOSE is set to True (the default), all the steps in the
calculation of a home prime are given as they are performed. For example, for
input 10 the trajectory (set of steps) is:

    Trajectory: 10 -> 2|5 -> 5|5 -> 5|11 -> 7|73

which shows that 10 has prime factors 2 and 5; 25 has prime factors 5 and 5; 55
has prime factors 5 and 11; and 511 has prime factors 7 and 73; producing 773,
which is prime.

If the constant $TIMER is set to True (it is False by default), the time, in
seconds, required to find the requested home prime is also displayed.

Implementation and Performance
------------------------------
Primality testing is performed by Raku's in-built is-prime() method.

Factorization is performed by the get-prime-factors() routine, which tests for
factors of 2, then for the odd numbers 3, 5, 7, ... in turn. This is one to two
orders of magnitude slower than the Perl implementation using Math::Prime::
Util::GMP, but still finds home primes in less than half a second for n = 2 to
47  But for n = 48, the factorization of 35957822911130063089 into 835996339
and 43011938251 is very slow because the smaller of the two factors is so big:
21 minutes as compared to 0.02 seconds for the Perl version!

=end comment
#==============================================================================

my Bool constant $TIMER   = False;
my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 168, Task #2: Home Prime (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $n where * > 1                           #= An integer greater than 1
)
#==============================================================================
{
    my DateTime $t0 = DateTime.now                 if $TIMER;

    my UInt $hp = $n;

    "Trajectory: $n".print                         if $VERBOSE;

    until $hp.is-prime
    {
        my @prime-factors = get-prime-factors( $hp );

        $hp = @prime-factors.join.Int;

        " -> %s".printf: @prime-factors.join: '|'  if $VERBOSE;
    }

    "\n".put                                       if $VERBOSE;

    "HP($n) = $hp".put;

    my DateTime $t = DateTime.now                  if $TIMER;

    "\n%s seconds\n".printf: ($t - $t0).Str        if $TIMER;
}

#------------------------------------------------------------------------------
sub get-prime-factors( Int:D $n where * > 1 --> Seq:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @prime-factors;
    my UInt $dividend = $n;

    while $dividend %% 2
    {
        @prime-factors.push: 2;

        $dividend = ($dividend / 2).Int;
    }

    my UInt $start = 3;

    L-OUTER:
    while $dividend > 1
    {
        loop (my UInt $factor = $start; ; $factor += 2)
        {
            if $factor.is-prime && $dividend %% $factor
            {
                @prime-factors.push: $factor;

                $dividend = ($dividend / $factor).Int;
                $start    =  $factor;

                if $dividend.is-prime
                {
                    @prime-factors.push: $dividend;
                    last L-OUTER;
                }

                next L-OUTER;
            }
        }
    }

    return @prime-factors.sort;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
