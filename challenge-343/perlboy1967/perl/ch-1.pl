#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-343#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Zero Friend
Submitted by: Mohammad Sajid Anwar

You are given a list of numbers.

Find the number that is closest to zero and return its distance to zero.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(min);
use List::MoreUtils qw(any);

sub zeroFriendMap (@ints) {
  min map { abs($_) } @ints;
}

sub zeroFriend (@ints) {
  my $m;
  any { $m = min($m // (),abs($_)); $_ == 0 } @ints;
  return $m;
}

is(zeroFriend(4,2,-1,3,-2),1,'Example 1');
is(zeroFriend(-5,5,-3,3,-1,1),1,'Example 2');
is(zeroFriend(7,-3,0,2,-8),0,'Example 3');
is(zeroFriend(-2,-5,-1,-8),1,'Example 4');
is(zeroFriend(-2,2,-4,4,-1,1),1,'Example 5');

is(zeroFriend((0) x 100_000),0,'Own example 1');
is(zeroFriend(1 .. 1000,0,1 .. 1000),0,'Own example 2');
is(zeroFriend((1 .. 2000,0)),0,'Own example 3');
 
done_testing;
