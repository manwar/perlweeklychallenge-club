#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'sum';

sub gcd { my ($A, $B) = @_; ($A, $B) = ($B % $A, $A) while $A; return $B }

sub chowla_number ($n) { sum(grep { gcd($n, $_) == $_ } 2 .. $n - 1) // 0 }

say join ', ', map { chowla_number($_) } 1 .. 20;
