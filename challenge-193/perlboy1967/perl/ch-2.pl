#!/bin/perl

=pod

The Weekly Challenge - 193
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-193/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Odd String
Submitted by: Mohammad S Anwar

You are given a list of strings of same length, @s.

Write a script to find the odd string in the given list. Use positional value
of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

Find the difference array for each string as shown in the example. Then pick 
the odd one out.

=cut

use v5.16;
use warnings;

use List::MoreUtils qw(slide);
use Test::More;


sub oddString {
  state $c = {map { ($_, ord($_) - ord('a')) } 'a' .. 'z'};

  my (%h,%freq,@k);

  for (@_) {
    no warnings 'once';
    my $k = join('|',slide { $c->{$b} - $c->{$a}} split //); 
    use warnings;

    $h{$k} = $_;
    $freq{$k}++;
  }

  @k = grep { $freq{$_} == 1 } keys %h;

  return $h{$k[0]} if (scalar(@k) == 1);
}


is(oddString("adc", "wzy", "abc"),'abc', 'abc');
is(oddString("aaa", "bob", "ccc", "ddd"), 'bob', 'bob');
is(oddString("abcd", "bcde", "cdef", "defh"), 'defh', 'defh');

done_testing;
