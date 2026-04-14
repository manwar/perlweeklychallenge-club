#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-367#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Conflict Events
Submitted by: Mohammad Sajid Anwar
You are given two events start and end time.

Write a script to find out if there is a conflict between the two events.
A conflict happens when two events have some non-empty intersection.

=cut


use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(any);

sub conflictEvents ($arEv1,$arEv2) {
  sub _t2i ($t) { int join '', $t =~ m#(\d+):(\d+)# }
  sub _adj (@t) { [$t[0], $t[1]>$t[0] ? $t[1] : 2400],
                    $t[1]>$t[0] ? () : [0, $t[1]] }
  sub _overlap ($ar1,$ar2) { $ar1->[0] < $ar2->[1] && $ar2->[0] < $ar1->[1] } 

  my $e1 = [_adj map { _t2i($_) } @$arEv1];
  my $e2 = [_adj map { _t2i($_) } @$arEv2];

  # Both time spans cross '00:00'?
  return true if (scalar @$e1 > 1 and scalar @$e2 > 1);

  # Put (if any) split timespan in $e1
  ($e1,$e2) = ($e2,$e1) if (scalar @$e2 > scalar @$e1);

  return boolean(any { _overlap($_,$$e2[0]) } @$e1);
}


is(conflictEvents(["10:00","12:00"],["11:00","13:00"]),true,'Example 1');
is(conflictEvents(["09:00","10:30"],["10:30","12:00"]),false,'Example 2');
is(conflictEvents(["14:00","15:30"],["14:30","16:00"]),true,'Example 3');
is(conflictEvents(["08:00","09:00"],["09:01","10:00"]),false,'Example 4');
is(conflictEvents(["23:30","00:30"],["00:00","01:00"]),true,'Example 5');
is(conflictEvents(["00:00","01:00"],["23:30","00:30"]),true,'Own test 1');
is(conflictEvents(["23:30","23:00"],["23:00","23:30"]),false,'Own test 2');
is(conflictEvents(["23:59","01:00"],["23:50","00:59"]),true,'Own test 3');

done_testing;
