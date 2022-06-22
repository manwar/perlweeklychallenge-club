#!/bin/perl

=pod

The Weekly Challenge - 170
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-170/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Kronecker Product
Submitted by: Mohammad S Anwar

You are given 2 matrices.

Write a script to implement Kronecker Product on the given 2 matrices.

For more information, please refer wikipedia page.

=cut

use v5.16;
use warnings;

use List::Util qw(max);
use List::MoreUtils qw(arrayify);

use Test::More;
use Test::Deep;

sub kroneckerProduct($$);
sub printMatrix ($$);

is_deeply(kroneckerProduct([[1,2],[3,4]], 
                           [[5,6],[7,8]]),
                           [[ 5, 6,10,12],
                            [ 7, 8,14,16],
                            [15,18,20,24],
                            [21,24,28,32]]);
say '=======================================';
is_deeply(kroneckerProduct([[1],[2]], 
                           [[3,5],[4,6]]),
                           [[3, 5],
                            [4, 6],
                            [6,10],
                            [8,12]]);
say '=======================================';
is_deeply(kroneckerProduct([[1,2]], 
                           [[5,6],[7,8]]),
                           [[5,6,10,12],
                            [7,8,14,16]]);
say '=======================================';
is_deeply(kroneckerProduct([[1,2],[3,4]], 
                           [[5,6,7]]),
                           [[ 5, 6,10,12,14],
                            [15,18,20,24,28]]);
say '=======================================';
is_deeply(kroneckerProduct([[1,2]], 
                           [[3],[4]]),
                           [[3,6],
                            [4,8]]);
say '=======================================';
is_deeply(kroneckerProduct([[1,2,3]], 
                           [[4],[5]]),
                           [[4, 8,12],
                            [5,10,15]]);
say '=======================================';
is_deeply(kroneckerProduct([[1,2,3],[4,5,6],[7,8,9]], 
                           [[9,8,7],[6,5,4],[3,2,1]]),
                           [[ 9, 8, 7,18,16,14,27,24,21 ],
                            [ 6, 5, 4,12,10, 8,18,15,12 ],
                            [ 3, 2, 1, 6, 4, 2, 9, 6, 3 ],
                            [36,32,28,45,40,35,54,48,42 ],
                            [24,20,16,30,25,20,36,30,24 ],
                            [12, 8, 4,15,10, 5,18,12, 6 ],
                            [63,56,49,72,64,56,81,72,63 ],
                            [42,35,28,48,40,32,54,45,36 ],
                            [21,14, 7,24,16, 8,27,18, 9 ]]);

done_testing;

sub kroneckerProduct($$) {
  my ($arA, $arB) = @_;

  printMatrix('A', $arA);
  printMatrix('B', $arB);

  my $r = [];

  my ($W1,$H1) = (scalar @{$arA->[0]}, scalar @$arA);
  my ($W2,$H2) = (scalar @{$arB->[0]}, scalar @$arB);

  foreach my $h1 (0 .. $H1 - 1) {
    foreach my $w1 (0 ..  $W1 - 1) {
      foreach my $h2 (0 .. $H2 - 1) {
        foreach my $w2 (0 ..  $W2 - 1) {
          my $h = ($H1 <= $H2 ? $h1 * $H1 + $h2 : $h2 * $H2 + $h1);
          my $w = ($W1 <= $W2 ? $w1 * $W1 + $w2 : $w2 * $W2 + $w1);
          $r->[$h][$w] = $arA->[$h1][$w1] * $arB->[$h2][$w2];
        }
      }
    }
  }

  printMatrix('A x B', $r);
  return $r;
}

sub printMatrix ($$) {
  my ($label, $matrix) = @_;

  my $w = max(map{length($_)} arrayify $matrix);
  my $fmt = sprintf("[ %s ]\n", join(' ', map { "%${w}d"} (1 .. @{$matrix->[0]})));

  say "$label:";
  foreach my $row (@$matrix) {
    printf($fmt, @$row);
  }
  print "\n";
}
