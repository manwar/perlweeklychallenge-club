#!/usr/bin/perl

# Perl Weekly Challenge - 109
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/#TASK2
#
# Task 2 - Four Squares Puzzle
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(sum);
use List::MoreUtils qw(minmax);
use Algorithm::Combinatorics qw(permutations);
use Scalar::Util qw(looks_like_number);

use Test::More;
use Test::Deep;

is_deeply(
  solveFourSquaresPuzzle([1..7]), 
  [
    '3,7,2,1,5,4,6',
    '4,5,3,1,6,2,7',
    '4,7,1,3,2,6,5',
    '5,6,2,3,1,7,4',
    '6,4,1,5,2,3,7',
    '6,4,5,1,2,7,3',
    '7,2,6,1,3,5,4',
    '7,3,2,5,1,4,6'
  ]
); 

is_deeply(
  solveFourSquaresPuzzle([2,2,3,3,4,4,1]), 
  [
    '3,4,1,2,2,3,4',
    '3,4,2,1,2,4,3',
    '4,2,3,1,3,2,4',
    '4,3,2,2,1,4,3'
  ]
);

done_testing;

sub solveFourSquaresPuzzle {
  my ($numbers) = @_;

  my %solutions;

  my $iter = permutations($numbers);
  while (my @p = @{$iter->next // []}) {
    my ($min,$max) = minmax(sum(@p[0..1]),sum(@p[1..3]),sum(@p[3..5]),sum(@p[5..6]));
    if ($min == $max) {
      $solutions{join(',',@p)}++;
    }
  }

  return [sort keys %solutions];
}
