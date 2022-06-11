#!/usr/bin/env perl
#
# ch-2.pl - Gamma function, Lanczos approximation
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.026;
use warnings;
use strict;
use List::Util qw< sum >;
use Math::Complex;

use experimental 'signatures';
no warnings 'uninitialized';

use constant {
    g   => 7,    # Arbitrary
   tol  => 1e-7, # Required precision in testing
};

# These coefficients are only valid for g = 7, @p = 9
# Credit: https://mrob.com/pub/ries/lanczos-gamma.html
my @p = (
     0.99999999999980993227684700473478,
   676.520368121885098567009190444019,
 -1259.13921672240287047156078755283,
   771.3234287776530788486528258894,
  -176.61502916214059906584551354,
    12.507343278686904814458936853,
    -0.13857109526572011689554707,
     9.984369578019570859563e-6,
     1.50563273514931155834e-7,
);

# Lanczos approximation of the gamma function
# Accepts a real or complex argument
sub gamma($z) {
    return pi / (sin($z * pi) * gamma(1 - $z)) if Re($z) < 0.5;

    my $A = $p[0] + sum map { $p[$_] / ($z + $_ - 1) } 1..$#p;
    my $t = $z + g - 0.5;

    sqrt(2*pi) * $A * $t**($z-0.5) * exp(-$t);
}

say gamma($ARGV[0]) and exit if defined $ARGV[0];

#
# Tests
#

use Test::More;

# Real tests
my %tests = (
    # Real tests
             1 =>  1,
             2 =>  1,
             3 =>  2,
             4 =>  6,
             5 => 24,
           0.5 =>       sqrt(pi),
           1.5 => 0.5 * sqrt(pi),
          -0.5 =>  -2 * sqrt(pi),

   # Complex tests
      '1-1i'   => 0.4980156681 + 0.1549498283*i,
    '0.5+0.5i' => 0.8181639995 - 0.7633138287*i,
      '5+3i'   => 0.0160418827 - 9.4332932898*i,
      '5-3i'   => 0.0160418827 + 9.4332932898*i,
);
gamma_ok($_, $tests{$_}) for sort keys %tests;

done_testing;

# Test complex or real inputs
sub gamma_ok($z,$exp) {
    my $gamma = gamma(cplx($z));

    ok(( abs(Re($gamma) - Re($exp)) <= tol 
     and abs(Im($gamma) - Im($exp)) <= tol ),
        "gamma($z) = $exp within " .tol)
            or diag "  got $gamma";
}
