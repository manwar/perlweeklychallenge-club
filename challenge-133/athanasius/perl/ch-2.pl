#!perl

###############################################################################
=comment

Perl Weekly Challenge 133
=========================

TASK #2
-------
*Smith Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 10 Smith Numbers in base 10.

According to [ https://en.wikipedia.org/wiki/Smith_number |Wikipedia]:

    In number theory, a Smith number is a composite number for which, in a
    given number base, the sum of its digits is equal to the sum of the digits
    in its prime factorization in the given number base.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Prime factors are found via a simple, brute-force search. This is inefficient,
but quite fast enough for the given task.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $TARGET => 10;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 133, Task #2: Smith Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @smith;

    for (my ($count, $n) = (0, 4); $count < $TARGET; ++$n)
    {
        if (is_smith( $n ))
        {
            push @smith, $n;
            ++$count;
        }
    }

    printf "The first %d Smith numbers: %s\n", $TARGET, join ', ', @smith;
}

#------------------------------------------------------------------------------
sub is_smith
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    my @prime_factors = prime_factors( $n );

    return 0 unless scalar @prime_factors > 1;    # Smith numbers are composite

    my $factor_digit_sum = 0;

    for (@prime_factors)            # Sum the digits of the prime factors of $n
    {
        $factor_digit_sum += $_ for split //;
    }

    my  $n_digit_sum  = 0;
        $n_digit_sum += $_ for split //, $n;             # Sum the digits of $n

    return $n_digit_sum == $factor_digit_sum;
}

#------------------------------------------------------------------------------
sub prime_factors
#------------------------------------------------------------------------------
{
    my ($n)    = @_;
    my  $max_f = int sqrt $n;
    my  @prime_factors;

    for (my $f = 2; $f <= $max_f && $n > 1; ++$f)
    {
        while ($n % $f == 0)
        {
            push @prime_factors, $f;
            $n /= $f;
        }
    }

    push @prime_factors, $n if $n > 1;

    return @prime_factors;
}

###############################################################################
