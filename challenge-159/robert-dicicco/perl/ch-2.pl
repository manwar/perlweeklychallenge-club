#!perl.exe

use strict;
use warnings;
use feature qw/say/;
use ntheory qw/factor is_prime is_square_free/;

# AUTHOR: Robert DiCicco
# DATE: 4-APR-2022
# Challenge 159 Moebius Number ( Perl )

sub checkSquareFree {           # return 1 if number is squae free, 0 if not
  my $num = shift;
  if(is_square_free($num)) {
    return(1);
  } else {
    return(0);
  }
}

sub getPrimeFactorCount {       # Get prime factor count
  my $num = shift;

  my @arr = factor($num);
  my $sz = scalar(@arr);
  if($sz % 2 == 0){
    return(1);                  # return 1 if even
  }

  return(0);                     # return 0 if not
}

my $n = $ARGV[0];               # command line arg, no checking!

my $sf = checkSquareFree($n);
my $pf = getPrimeFactorCount($n);

print("Input: n = $n\n");

if(($pf == 1)&&($sf == 1)) {           # has even number of prime factors and is square free
  print("Output: 1\n");
} elsif (($pf == 0) && ($sf == 1)) {   # has odd number of prime factors and is square free
  print("Output: -1\n");
} elsif ( $sf == 0 ) {                 # number is not square free
  print("Output: 0\n");
} else { die "Error!!!"};              # something is wrong!!
