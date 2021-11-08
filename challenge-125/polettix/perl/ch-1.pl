#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'first';

sub factor_in_pairs ($n) {
   map { [$_, $n / $_] } grep { !($n % $_) } 1 .. sqrt($n)
}

sub pythagorean_triples ($N) {
   my @retval;
   my $r = 0;
   R:
   while ('necessary') {
      $r += 2;
      for my $pair (factor_in_pairs($r * $r / 2)) {
         my ($s, $t) = $pair->@*;
         my @triple = ($r + $s, $r + $t, $r + $s + $t);
         last R if $s == 1 && $N < $triple[0];
         push @retval, \@triple if first { $N == $_ } @triple;
      }
   }
   return @retval;
}

my $N = shift // 5;
my @triples = pythagorean_triples($N);
if (@triples) { say '(' . join(', ', $_->@*) . ')' for @triples }
else          { say -1 }
