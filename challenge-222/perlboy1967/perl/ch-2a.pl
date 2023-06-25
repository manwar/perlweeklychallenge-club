#!/bin/perl

=pod

The Weekly Challenge - 222
- https://theweeklychallenge.org/blog/perl-weekly-challenge-222

Author: Niels 'PerlBoy' van Dijke

Task 2: Last Member
Submitted by: Mohammad S Anwar

You are given an array of positive integers, @ints.

Write a script to find the last member if found otherwise return 0. Each turn pick
2 biggest members (x, y) then decide based on the following conditions, continue this
until you are left with 1 member or none.

||  a) if x == y then remove both members

||  b) if x != y then remove both members and add new member (y-x)

=cut

use v5.16;

use common::sense;

use Test::More;

use List::MoreUtils qw(firstidx);

sub lastMember2 (@) {
  @_ = sort { $b <=> $a } @_;

  while (@_ > 1) {
    my ($a,$b,$d) = (shift,shift); $d = $a - $b;
    if ($d != 0) { 
      return $d if (!@_);
      push(@_,$d,splice(@_,firstidx {$_ <= $d} @_));
    }
  }

  shift;
}

is(lastMember2(2,7,4,1,8,1),1);
is(lastMember2(1),1);
is(lastMember2(1,1),undef);
is(lastMember2(0,1,2,3),0);
is(lastMember2(0,2,0),2);

done_testing;
