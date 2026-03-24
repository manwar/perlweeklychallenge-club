#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-366#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Valid Times
Submitted by: Mohammad Sajid Anwar

You are given a time in the form ‘HH:MM’. The earliest possible time is ‘00:00’ 
and the latest possible time is ‘23:59’. In the string time, the digits represented
by the ‘?’ symbol are unknown, and must be replaced with a digit from 0 to 9.

Write a script to return the count different ways we can make it a valid time.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub validTimes ($ts) {
  # Warning: Black magic ahead ;-)
  state $hRe //= {
    '\d\d'    =>  1, '\?\?'    =>  24,
    '[01]\?'  => 10, '2\?'     =>   4,
    '\?[0-3]' =>  3, '\?[4-9]' =>   2,
  };
  state $mRe //= { '\d\d' => 1, '\d\?' => 10, '\?\d' => 6, '\?\?' => 60 };
  state $mH  //= { map { my $h = $_; $h =~ s/[\\\[\]-]//g; $h =~ tr/?/_/; ("H$h",$_) } keys %$hRe };
  state $mM  //= { map { my $m = $_; $m =~ s/[\\\[\]-]//g; $m =~ tr/?/_/; ("M$m",$_) } keys %$mRe };
  state $reH //= join(' | ', map { sprintf qq{(?<%s>%s)}, $_, $mH->{$_} } sort keys %$mH);
  state $reM //= join(' | ', map { sprintf qq{(?<%s>%s)}, $_, $mM->{$_} } sort keys %$mM);

  # All the state hocus pocus stuff above is all for this:
  state $re //= "^(($reH):($reM))\$";

  $ts =~ m#$re#ox;

  # We now have one $+{H...} and one $+{M...} named back reference
  return $hRe->{$mH->{(grep /^H/,keys %+)[0]}} * $mRe->{$mM->{(grep /^M/,keys %+)[0]}};
}

is(validTimes('00:00'), 1,           'Own test 01');
is(validTimes('00:0?'), 10,          'Own test 02');
is(validTimes('00:?0'), 6,           'Own test 03');
is(validTimes('00:??'), 6 * 10,      'Own test 04');
 
is(validTimes('0?:00'), 10,          'Own test 05');
is(validTimes('0?:0?'), 10 * 10,     'Own test 06');
is(validTimes('0?:?0'), 10 * 6,      'Own test 07');
is(validTimes('0?:??'), 10 * 6 * 10, 'Own test 08');

is(validTimes('1?:00'), 10,          'Own test 09');
is(validTimes('1?:0?'), 10 * 10,     'Own test 10');
is(validTimes('1?:?0'), 10 * 6,      'Own test 11');
is(validTimes('1?:??'), 10 * 6 * 10, 'Own test 12');

is(validTimes('2?:00'), 4,           'Own test 13');
is(validTimes('2?:0?'), 4 * 10,      'Own test 14');
is(validTimes('2?:?0'), 4 * 6,       'Own test 15');
is(validTimes('2?:??'), 4 * 6 * 10,  'Own test 16');

is(validTimes('?0:00'), 3,           'Own test 17');
is(validTimes('?0:0?'), 3 * 10,      'Own test 18');
is(validTimes('?0:?0'), 3 * 6,       'Own test 19');
is(validTimes('?0:??'), 3 * 6 * 10,  'Own test 20');

is(validTimes('??:00'), 24,          'Own test 21');
is(validTimes('??:0?'), 24 * 10,     'Own test 22');
is(validTimes('??:?0'), 24 * 6,      'Own test 23');
is(validTimes('??:??'), 24 * 6 * 10, 'Own test 24');

done_testing;
