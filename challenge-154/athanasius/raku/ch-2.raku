use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 154
=========================

TASK #2
-------
*Padovan Prime*

Submitted by: Mohammad S Anwar

A Padovan Prime is a Padovan Number that’s also prime.

In number theory, the Padovan sequence is the sequence of integers P(n) defined
by the initial values.

 P(0) = P(1) = P(2) = 1

and then followed by

 P(n) = P(n-2) + P(n-3)

First few Padovan Numbers are as below:

 1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, ...

Write a script to compute first 10 distinct Padovan Primes.

Expected Output

 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
1. Values of P(3) and above are generated using the given recurrence relation
   P(n) = P(n-2) + P(n-3).
2. Each newly-generated Padovan number is tested for primality using Raku's
   built-in is-prime() method.
3. To meet the requirement that output values be distinct, each newly-found
   Padovan prime is then checked against already-found primes using Raku's
   built-in none() method.

=end comment
#==============================================================================

my UInt constant $TARGET = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 154, Task #2: Padovan Prime (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt  @primes;
    my UInt ($p0, $p1, $p2) = 1 xx 3;

    while +@primes < $TARGET
    {
        my UInt $p3 = $p1 + $p0;

        @primes.push: $p3 if $p3.is-prime && $p3 == @primes.none;
       
        ($p0, $p1, $p2) = $p1, $p2, $p3;                  # Recurrence relation
    }

    "The first $TARGET distinct Padovan Primes:\n{ @primes.join: ', ' }".put;
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
