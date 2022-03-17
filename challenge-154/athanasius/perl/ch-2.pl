#!perl

###############################################################################
=comment

Perl Weekly Challenge 154
=========================

TASK #2
-------
*Padovan Prime*

Submitted by: Mohammad S Anwar

A Padovan Prime is a Padovan Number that's also prime.

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
1. Values of P(3) and above are generated using the given recurrence relation
   P(n) = P(n-2) + P(n-3).
2. Each newly-generated Padovan number is tested for primality using the func-
   tion is_prime() from the CPAN module Math::Prime::Util.
3. To meet the requirement that output values be distinct, each newly-found
   Padovan prime is then checked against already-found primes using the list-
   reduction function none() from the standard module List::Util.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util        qw( none );
use Math::Prime::Util qw( is_prime );

const my $TARGET => 10;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 154, Task #2: Padovan Prime (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my  @primes;
    my ($p0, $p1, $p2) = (1) x 3;

    while (scalar @primes < $TARGET)
    {
        my $p3 = $p1 + $p0;

        push @primes, $p3 if is_prime( $p3 ) && none { $_ == $p3 } @primes;

        ($p0, $p1, $p2) = ($p1, $p2, $p3);                # Recurrence relation
    }

    printf "The first %d distinct Padovan Primes:\n%s\n",
            $TARGET, join ', ', @primes;
}

###############################################################################
