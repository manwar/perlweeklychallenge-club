#!perl.exe

# AUTHOR: Robert DiCicco
# DATE:   2022-06-06
# Challenge 168 Home Prime ( Perl )

use strict;
use warnings;
use ntheory qw/is_prime factor divisors/;

my $hp = 8;
my @results;

sub homeprime {
  my $hp = shift;

  my @factors = factor($hp);

  my $hp_new = join('',@factors);

  return($hp_new);

}

my $flag = 1;

push(@results, $hp);

while ( $flag > 0) {

  my $retval = homeprime($hp);

  if ( is_prime($retval) ){

    push(@results, $retval);

    $flag = 0;

  } else {

    push(@results, $retval);

    $hp = $retval;

  }

}

  print ("@results ");

  print("\n");
