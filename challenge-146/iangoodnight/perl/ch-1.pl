#!/usr/bin/perl
# ch-1.pl

=begin comment

  https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
 
  ## Task 1 > 10001st Prime Number
  ================================
 
  Write a script to generate the 10001st prime number.

=end comment
=cut

use strict;
use warnings;

################################################################################
# PWC Solution #################################################################
################################################################################

sub get_prime {
  my $nth    = shift;
  my @primes = ( 2, 3 );
  my $num    = 5;

  if ( $nth <= 2 ) {
    return $primes[ $nth - 1 ];
  }

  while ( scalar @primes < $nth ) {
    my $is_prime = 1;
    for my $prime (@primes) {
      if ( int( sqrt($num) ) < $prime ) {
        last;
      }
      if ( $num % $prime == 0 ) {
        $is_prime = 0;
        last;
      }
    }
    if ($is_prime) {
      push @primes, $num;
    }

    $num += 2;
  }
  return $primes[-1];
}

################################################################################
# Utilities ####################################################################
################################################################################

sub get_suffix {
  my $last_digit = substr shift, -1;

  if ( $last_digit == 0 || $last_digit >= 4 ) {
    return 'th';
  }
  if ( $last_digit == 1 ) {
    return 'st';
  }
  if ( $last_digit == 2 ) {
    return 'nd';
  }
  if ( $last_digit == 3 ) {
    return 'rd';
  }
  return q{ };
}

sub color_string {
  my $str    = shift;
  my $color  = shift;
  my %colors = (
    yellow => "\e[33m",
    green  => "\e[32m",
  );
  my $reset = "\e[0m";

  return $colors{$color} . $str . $reset;
}

################################################################################
# Main #########################################################################
################################################################################

my $nth          = shift @ARGV // '10001';
my $prime        = get_prime $nth;
my $suffix       = get_suffix $nth;
my $num_string   = color_string( $nth . $suffix, 'yellow' );
my $prime_string = color_string( $prime, 'green' );

print "The $num_string prime number is $prime_string\n";
