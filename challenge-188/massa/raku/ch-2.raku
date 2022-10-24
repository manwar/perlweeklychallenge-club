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
is 6, make-total-zero 5, 13;
is 4, make-total-zero 3, 5;
is 13, make-total-zero 100, 19;
is 5, make-total-zero 100, 20;
is 535, make-total-zero 10000, 19;

done-testing;

subset Positive of UInt where *;

sub make-total-zero(Positive $x, Positive $y) {
  my $count = 1;
  sink $x, $y, { ++$count if $^x > $^y; abs $^x - $^y } ... 0;
  $count
}

