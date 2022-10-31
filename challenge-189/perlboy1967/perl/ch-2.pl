#!/bin/perl

=pod

The Weekly Challenge - 189
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-189/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Array Degree
Submitted by: Mohammad S Anwar

You are given an array of 2 or more non-negative integers.

Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, 
having the degree of the given array.

 ||  The degree of an array is the maximum frequency of an element in the array.

=cut

use v5.16;
use warnings;

use List::Util qw(max min);
use List::MoreUtils qw(frequency firstidx);

use Test::More;
use Test::Deep qw(cmp_deeply);


sub arrayDegree {

  # Find maximum frequency
  my %freq = frequency @_;
  my $medianFreq = max(values %freq);

  # Get median(s)
  my @medians = sort { $a <=> $b } grep { $freq{$_} == $medianFreq } keys %freq;

  my $candidates;

  # get candidates
  for my $median (@medians) {

    my $minIdx = firstidx { $_ == $median} @_;
    my $maxIdx = @_ - (firstidx { $_ == $median } reverse @_) - 1;

    push(@$candidates,[@_[$minIdx .. $maxIdx]]);

  }

  # Find mimimum length of candidates which may qualify
  my $minLength = min(map scalar @{$_}, @$candidates);

  # Select and sort sub lists
  @$candidates = sort {$a->[0] <=> $b->[0]} grep { scalar @$_ == $minLength } @$candidates;

  return $candidates;
}


cmp_deeply(arrayDegree(1,3,3,2),[[3,3]], 'Example 1');
cmp_deeply(arrayDegree(1,2,1,3),[[1,2,1]], 'Example 2');
cmp_deeply(arrayDegree(1,3,2,1,2),[[2,1,2]], 'Example 3');
cmp_deeply(arrayDegree(1,1,2,3,2),[[1,1]], 'Example 4');
cmp_deeply(arrayDegree(2,1,2,1,1),[[1,2,1,1]], 'Example 5');

cmp_deeply(arrayDegree(2,2,1,3,2,1,1,3,3),[[1,3,2,1,1],[2,2,1,3,2]], 'Example 6');

done_testing;
