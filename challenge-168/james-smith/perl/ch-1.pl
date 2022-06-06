#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Math::Prime::Util qw(is_prime);

## This is straight forward.
## In each interation of the loop, we remove the lowest number of the triple,
## and at the same time set the highest number to the sum of the previous 2
## lowest numbers
##
## If the number isn't prime OR the number is the same as the previous number
## then we restart the loop with redo, if not we display the number and
## continue until we have displayed the first 13 perrin primes.

my ($r,$s,$t)=(3,0,2);
($r,$s,$t)=($s,$t,$r+$s), is_prime($t) && $t!=$s ? (say $t) : (redo) for 1..13

