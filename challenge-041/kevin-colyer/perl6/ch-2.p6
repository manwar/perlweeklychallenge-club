#!/usr/bin/perl6
use v6;

use Test;


=begin pod

Write a script to display first 20 Leonardo Numbers. Please checkout wiki page for more information.
For example:

L(0) = 1
L(1) = 1
L(2) = L(0) + L(1) + 1 = 3
L(3) = L(1) + L(2) + 1 = 5
and so on.

=end pod

my @cache;
multi sub Leonardo(Int:D $n where * == 0) { 1 }
multi sub Leonardo(Int:D $n where * == 1) { 1 }
multi sub Leonardo(Int:D $n where * > 1 )  {
   return @cache[$n] if @cache[$n];
   return @cache[$n] = Leonardo($n-1)+Leonardo($n-2)+1;
}

say "$_ -> "~Leonardo($_) for ^21;
