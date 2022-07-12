#!/bin/perl

=pod

The Weekly Challenge - 173 - Task 2
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-172/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Sylvester’s sequence
Submitted by: Mohammad S Anwar

Write a script to generate first 10 members of Sylvester's sequence. For more 
informations, please refer to the wikipedia page.

=cut

use v5.16;
use warnings;

use bigint;

use List::Util qw(reduce);


foreach (1 .. 10) {
  say sylvesterSequence($_);
}


sub sylvesterSequence {
  my ($i) = @_;

  state $s = [1];

  my $n = scalar(@$s);
  while (!defined $s->[$i]) {
    # Use 'reduce' as 'product'
    $s->[$n++] = (reduce { $a *= $b } (1,@$s)) + 1;
  }

  return $s->[$i];
}
