#!/bin/perl

=pod

The Weekly Challenge - 314
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-314#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Equal Strings
Submitted by: Mohammad Sajid Anwar

You are given three strings.

You are allowed to remove the rightmost character of a string to make all equals.

Write a script to return the number of operations to make it equal otherwise -1.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::Util qw(min);

sub equalStrings (@list) {
  my $steps = 0;

  # Determin shortest length
  my $l = min(map { length } @list);

  # Shorten to minimum equal length and keep track of 'steps'
  @list = map { $steps += length($_) - $l; substr($_,0,$l) } @list;

  while ($l > 0) {
    # Do we have a equal list?
    my %h; $h{$list[$_]}++ for (0 .. $#list);
    if (keys %h == 1) {
      last;
    } else {
      # Nope, adjust length and keep track of 'steps'
      $l--;
      if ($l > 0) {
        substr($list[$_],$l,1,'') for (0 .. $#list);
        $steps += scalar @list;
      } else {
        $steps = -1;
      }
    }
  }

  return $steps;
}

is(equalStrings('abc','abb','ab'),2,'Example 1');
is(equalStrings('ayz','cyz','xyz'),-1,'Example 2');
is(equalStrings('yza','yzb','yzc'),3,'Example 3');

done_testing;

