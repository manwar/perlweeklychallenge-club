#!perl.exe

# AUTHOR: Robert DiCicco
# DATE: 28-MAR-2022
# Challenge 158 Additive Primes ( Perl )

use strict;
use warnings;
use ntheory qw/is_prime/;
use feature qw/say/;

sub sum_of_digits {
  my $num = shift;

  my $digsum = 0;
  my @digarr = split(//,$num);

  foreach( @digarr ) {
    $digsum += $_;
  }

  if (is_prime($digsum)) {
    return $digsum;
  } else {
    return -1;
  }
}

my $TARGET = 100;
my $i = 1;
my $cnt = 0;

my @outarr;

while ( $i < $TARGET ) {

  if(! is_prime($i)){
    $i++;
    next;
  }

  my ($dsum) = sum_of_digits($i);

  if ($dsum > 0 ) {
    push(@outarr, $i);
  }

  $i++;
}

say "@outarr ";
