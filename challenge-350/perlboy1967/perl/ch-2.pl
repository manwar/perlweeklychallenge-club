#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-350#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Shuffle Pairs
Submitted by: E. Choroba

If two integers A <= B have the same digits but in different orders, we say
that they belong to the same shuffle pair if and only if there is an integer
k such that A = B * k. k is called the witness of the pair.

For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 = 9513.

Interestingly, some integers belong to several different shuffle pairs. For example, 
123876 forms one shuffle pair with 371628, and another with 867132, as 
123876 * 3 = 371628, and 123876 * 7 = 867132.

Write a function that for a given $from, $to, and $count returns the number of
integers $i in the range $from <= $i <= $to that belong to at least $count different
shuffle pairs.

PS: Inspired by a conversation between Mark Dominus and Simon Tatham at Mastodon.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub shufflePairs ($from,$to,$count) {
  my $spCount = 0;
  for my $n ($from .. $to) {
    my $max = join '', sort { $b <=> $a } split(//,$n);
    next if $max < $n * 2;
    my $i = 0;
    for my $f (2 .. int($max/$n)) {
      my $s = join '', sort { $b <=> $a } split(//,($n * $f));
      if ($s == $max) {
        $i++;
        if ($i >= $count) {
          $spCount++; last;
        }
      }
    }
  }
  return $spCount;
}

is(shufflePairs(1,1000,1),0,'Example 1');
is(shufflePairs(1500,2500,1),3,'Example 2');
is(shufflePairs(1_000_000,1_500_000,5),2,'Example 3');
is(shufflePairs(13_427_000,14_100_000,2),11,'Example 4');
is(shufflePairs(1030,1130,1),2,'Example 5');

done_testing;
