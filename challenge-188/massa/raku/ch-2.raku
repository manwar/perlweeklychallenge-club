#!/usr/bin/env raku

=begin pod

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Total Zero

    You are given two positive integers C<$x> and C<$y>.

    Write a script to find out the number of operations needed to make both
    C<ZERO>. Each operation is made up either of the followings:

=begin code
    $x = $x - $y if $x >= $y

    or

    $y = $y - $x if $y >= $x (using the original value of $x)
=end code

=end pod

use Test;

is 5, make-total-zero 5, 4;
is 3, make-total-zero 4, 6;
is 4, make-total-zero 2, 5;
is 3, make-total-zero 3, 1;
is 5, make-total-zero 7, 4;

done-testing;

subset Positive of UInt where *;

sub make-total-zero(Positive $x is copy, Positive $y is copy) {
  my $count = 0;
  while $x and $y {
    ++$count;
    $_ = $x;
    $x -= $y when $x ≥ $y;
    $y -= $_ when $y ≥ $_;
  }
  $count
}

