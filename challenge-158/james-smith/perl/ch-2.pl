#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(is_prime);

my ($N,$x) = (shift || 1000,1);

say "\nFirst series";
(is_prime $_) && say while $N >= ($_ = 3*$x*++$x+1);

$x=1;
say "\nSecond series";

(is_prime $_) && say while $N >= ($_ = 3 * $x * ( 2 + $x++ ) + 4);

say '';
