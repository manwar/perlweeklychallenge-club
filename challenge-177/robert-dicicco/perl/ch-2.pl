#!perl.exe

use strict;
use warnings;
use ntheory qw/is_prime/;
no warnings 'experimental::smartmatch';
use 5.30.0;

# AUTHOR: Robert DiCicco
# DATE: 2022-08-08
# Challenge 177 Palindromic Prime Cyclops ( Perl )

sub MidChar {

  my $str = shift;

  my $ln = length($str);

  given($ln){

    when (3) { return(substr($str,1,1)); }

    when (5) { return(substr($str,2,1)); }

    when (7) { return(substr($str,3,1)); }

    default  { return(-1); }

  }

}

my $count = 0;

my $candidate = 100;

while( $count <= 20 ) {

  if(length($candidate) % 2 == 0) {

    $candidate++;

     next;

  }

  if (is_prime($candidate) && $candidate == reverse($candidate) && MidChar($candidate) == 0 ) {

    print("$candidate ");

    $count++;

  }

  $candidate++;

}

print("\n");
