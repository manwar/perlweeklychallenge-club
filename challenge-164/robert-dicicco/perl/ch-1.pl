#!perl.exe

use strict;
use warnings;
use feature qw/say/;
use ntheory qw/is_prime/;

# AUTHOR: Robert DiCicco
# DATE: 2022-05-09
# Challenge #164 Prime Palindrome ( Perl )

my $prime_rev;

for (my $n = 1; $n < 1000; $n++){
  if (is_prime($n)) {
    $prime_rev = reverse($n);
    if ((is_prime($prime_rev)) && ($n == $prime_rev)){
      print "$n ";
    }
  }
}

say " ";
