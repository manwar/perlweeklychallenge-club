#!perl.exe

use strict;
use warnings;
use 5.30.0;

# Author: Robert DiCicco
# Date: 31-JAN-2022
# Challenge 150 Fibonacci Words (Perl)

my $a = '1234';
my $b = '5678';

say "Fibonacci Words";
say $a;
say $b;

my $retval=Fib($a, $b);

# get the 51st character
my $fibchr = substr($retval, 50, 1);
say "51st digit is $fibchr";

# recursive routine to create fibonacci series, but using strings

sub Fib {
  my $val = $_[0] . $_[1];
  say $val;

  # if new string length is less than 51, go another round using new combined string

  if (length($val) < 51) {
    Fib($_[1], $val);
  } else {
    # return the string if length 51 or greater
    return $val;
  }
}
