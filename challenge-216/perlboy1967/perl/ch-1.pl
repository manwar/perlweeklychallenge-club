#!/bin/perl

=pod

The Weekly Challenge - 216
- https://theweeklychallenge.org/blog/perl-weekly-challenge-216

Author: Niels 'PerlBoy' van Dijke

Task 1: Registration Number
Submitted by: Mohammad S Anwar

You are given a list of words and a random registration number.

Write a script to find all the words in the given list that has every letter in the
given registration number.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep;

sub registrationNumber ($\@) {
  my $rnRE = sprintf  '[%s]',
                      join('].*?[',
                           sort grep /[a-z]/,split //,lc shift);
  map { $_->[0] } 
      grep { $_->[1] =~ /$rnRE/ } 
           map { [$_,join('',sort split //,lc)] } 
               @{$_[0]};
}

is_deeply([registrationNumber('AB1 2CD',@{[qw{abc abcd bcd}]})],
          [qw{abcd}]);
is_deeply([registrationNumber('007 JB', @{[qw{job james bjorg}]})],
          [qw{job bjorg}]);
is_deeply([registrationNumber('C7 RA2', @{[qw{crack road rac}]})],
          [qw{crack rac}]);
is_deeply([registrationNumber('T7 RR9', @{[qw{tracker roadster rac}]})],
          [qw{tracker roadster}]);
is_deeply([registrationNumber('P3R L58',@{[qw{perl raku}]})],
          [qw{perl}]);

done_testing;
