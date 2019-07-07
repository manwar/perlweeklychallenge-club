#!perl

################################################################################
=comment

Perl Weekly Challenge 015
=========================

Task #1
-------

Write a script to generate first 10 strong and weak prime numbers.

  For example, the nth prime number is represented by p(n).

  p(1) = 1
  p(2) = 3
  p(3) = 5

  Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
  Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( prime_iterator );

const my $SERIES_LENGTH => 10;

$| = 1;

MAIN:
{
    my %primes   = map { $_ => [] } qw( strong weak );
    my $iterator = prime_iterator();
    my $previous = $iterator->();
    my $current  = $iterator->();

    while (scalar $primes{strong}->@* < $SERIES_LENGTH ||
           scalar $primes{weak  }->@* < $SERIES_LENGTH)
    {
        my $next =  $iterator->();
        my $mean = ($previous + $next) / 2;
        my $type = ($current  > $mean) ? 'strong' :
                   ($current  < $mean) ? 'weak'   : 'balanced';

        if ($type ne 'balanced' && scalar $primes{$type}->@* < $SERIES_LENGTH)
        {
            push $primes{$type}->@*, $current;
        }

        ($previous, $current) = ($current, $next);
    }

    print "\n";

    for my $type (qw( strong weak ))
    {
        printf "The first %d %-*s primes are: %s\n",
                $SERIES_LENGTH, length('strong'), $type,
                join(', ', map { sprintf '%2d', $_ } $primes{$type}->@*);
    }
}

################################################################################
