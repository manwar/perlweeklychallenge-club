#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub valid_times{
  my $res = 1;
  my @t = split '',$_[0];
  if($t[0] eq '?') {
    $res = $t[1] eq '?' ? 24 : $t[1] lt '4' ? 3 : 2
  } elsif($t[1] eq '?') {
    $res = $t[0] lt '2' ? 10 : 4
  }
  $res * ($t[3] eq '?' ? 6 : 1) * ($t[4] eq '?' ? 10 : 1)
}

is valid_times('?2:34'),3,'Example 1';
is valid_times('?4:?0'),12,'Example 2';
is valid_times('??:??'),1440,'Example 3';
is valid_times('?3:45'),3,'Example 4';
is valid_times('2?:15'),4,'Example 5';

