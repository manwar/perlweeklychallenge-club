#!/usr/bin/perl
# ch-2.pl

=begin comment

 * https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
 *
 * Task 2 > Smith Numbers
 * ======================
 *
 * Write a script to generate the first 10 `Smith Numbers` in base 10.
 *
 * According to Wikipedia:
 *
 * > In number theory, a Smith number is a composite number for which, in a
 * > given number base, the sum of its digits is equal to the sum of the digits
 * > in its prime factorization in the given number base.

=end comment
=cut

use strict;
use warnings;
use utf8;
use Data::Dumper;

################################################################################
# Our PWC solution, along with some help subroutines
################################################################################

# First, we need a utility function to find and return our prime factors
sub prime_factors {
  my $number = shift;

  $number =~ s{ # Trim whitespace, probably unnecessary, but it won't hurt
    \A          # Start of the line
    \s+         # Leading whitespace
    |           # Alternating with
    \s+         # Trailing whitespace
    \z          # End of line
  }{}gx;

  # Validate our input is an integer
  if ( !$number =~ m/\A\d+\z/ ) {

    # Bail
    return 0;
  }
  my @factors;
  my $divisor = 2;    # Starting with 2, we'll divide and check for modulo

  while ( $number >= 2 ) {
    if ( $number % $divisor == 0 ) {

      # If modulo is zero, push $divisor to @factors
      push @factors, $divisor;
      $number /= $divisor;
    }
    else {
      # Else, increment $divisor and try again
      $divisor += 1;
    }
  }
  return \@factors;
}

# Helper to reduce number to sum of its digits
sub sum_digits {
  my $number = shift;

  # Trim
  $number =~ s{ \A \s+ | \s+ \z }{}gx;

  # Split digits
  my @digits = split //, $number;

  # Reduce
  my $sum = 0;
  foreach my $digit (@digits) {
    $sum += $digit;
  }
  return $sum;
}

# Find `Smith Numbers` with the help of our two subroutines, `prime_factors`
# and `sum_digits`
sub find_smith_numbers {

  # We need to find the first ten, but we might as well write it to find more
  my $limit = shift // '10';
  my @smith_numbers;

  # Smith Numbers are not prime numbers, so we might as well start at 4
  my $test = '4';

  # Search until we hit our limit
  while ( scalar @smith_numbers < $limit ) {
    my @primes     = @{ prime_factors($test) };
    my $factor_sum = 0;

    # Reduce @primes to sum of its digits
    foreach my $prime (@primes) {
      $factor_sum += sum_digits($prime);
    }

    my $digit_sum = sum_digits($test);

    # Check for matching sums and for prime number (if scalar @primes == 1,
    # $test is a prime number)
    if ( $factor_sum == $digit_sum && scalar @primes != 1 ) {
      push @smith_numbers, $test;
    }

    $test += 1;
  }
  return \@smith_numbers;
}

################################################################################
# Utilities
################################################################################

sub list_with_oxford {
  my @list        = @{ +shift };
  my $last_number = $list[-1];

  return join( ', ', @list[ 0 .. $#list - 1 ] ) . ', and ' . $last_number;
}

################################################################################
# Main
################################################################################

sub main {
  my $limit         = shift @ARGV // '10';
  my $smith_numbers = find_smith_numbers $limit;
  my $result_string = list_with_oxford $smith_numbers;

  print "The first $limit Smith Numbers are $result_string.\n";
  return 1;
}

main();
