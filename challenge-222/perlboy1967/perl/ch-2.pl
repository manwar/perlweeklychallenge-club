#!/bin/perl

=pod

The Weekly Challenge - 222
- https://theweeklychallenge.org/blog/perl-weekly-challenge-222

Author: Niels 'PerlBoy' van Dijke

Task 2: Last Member
Submitted by: Mohammad S Anwar

You are given an array of positive integers, @ints.

Write a script to find the last member if found otherwise return 0. Each turn pick any 
2 members (x, y) then decide based on the following conditions, continue this until you
are left with 1 member or none.

||  a) if x == y then remove both members

||  b) if x != y then remove both members and add new member (y-x)

=cut

use v5.16;

use common::sense;

use Test::More;

use List::Util qw(shuffle);

sub lastMember (@) {
  printf "Input: [%s]\n", join(',',@_);

  @_ = shuffle @_;
  printf "Shuffled: [%s]\n", join(',',@_);

  while (@_ > 1) {
    ($a,$b) = (shift,shift);
    push(@_,$b - $a) if ($a != $b);    
    printf "($a,$b) => [%s]\n", join(',',@_);
  }

  printf "Output: %s\n\n", $_[0] // '(undef)';

  return $_[0];
}

# Call random seed with TWC number to get predicted 'random shuffle'
srand(222);
is(lastMember(2,7,4,1,8,1),1);
is(lastMember(1),1);
is(lastMember(1,1),undef);

done_testing;
