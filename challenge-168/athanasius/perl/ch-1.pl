#!perl

###############################################################################
=comment

Perl Weekly Challenge 168
=========================

TASK #1
-------
*Perrin Prime*

Submitted by: Roger Bell_West

The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is
the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)

        A Perrin prime is a number in the Perrin sequence which is also a prime
        number.

Calculate the first 13 Perrin Primes.

f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193,
         792606555396977]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Generate successive terms in the Perrin sequence using the recurrence relation
p(n) = p(n-2) + p(n-3).

Test whether each new term is a prime number using the is_prime() function from
the CPAN module Math::Prime::Util (aka ntheory).

Output Perrin primes as they are found, until the output count reaches 13.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( is_prime );

const my @INIT_TRIPLET => (3, 0, 2);
const my $TARGET       => 13;
const my $USAGE        => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 168, Task #1: Perrin Prime (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @triplet = @INIT_TRIPLET;
    my %primes  = map { $_ => 1 } grep { is_prime $_ } @triplet;

    printf "f(%d) =\n  %s", $TARGET,
                            join ', ', sort { $a <=> $b } keys %primes;

    while (scalar keys %primes < $TARGET)
    {
        my $n = $triplet[ 0 ] + $triplet[ 1 ];

        shift @triplet;
        push  @triplet, $n;

        if (is_prime $n)
        {
            ++$primes{ $n };

            print ", $n" if $primes{ $n } == 1;
        }
    }

    print "\n";
}

###############################################################################
