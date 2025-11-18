#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-348#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Covert Time
Submitted by: Mohammad Sajid Anwar

You are given two strings, $source and $target, containing time in 24-hour time form.

Write a script to convert the source into target by performing one of the following operations:

1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes

Find the total operations needed to get to the target.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub convertTime ($source,$target) {
  my $steps = 0;
  $source =~ s#(\d+):(\d+)#60*$1 + $2#e;
  $target =~ s#(\d+):(\d+)#60*$1 + $2#e;
  $target += 24*60 unless ($target > $source);
  while ($source != $target) {
    for (qw{60 15 5 1}) {
      if ($source + $_ <= $target) {
        $source += $_; last;
      }
    }
    $steps++;
  }
  return $steps;
}

is(convertTime('02:30','02:45'),1,'Example 1');
is(convertTime('11:55','12:15'),2,'Example 2');
is(convertTime('09:00','13:00'),4,'Example 3');
is(convertTime('23:45','00:30'),3,'Example 4');
is(convertTime('14:20','15:25'),2,'Example 5');
is(convertTime('00:00','23:59'),32,'Own Example');

done_testing;
