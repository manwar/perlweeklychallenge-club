#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(alternatingvowelsconsonants(['relocate', 'delocate', 'allocate']), ['locate'], 'example 1');
is_deeply(alternatingvowelsconsonants(['apple', 'banana', 'cherry']), [], 'example 2');
is_deeply(alternatingvowelsconsonants(['navigate', 'cavity', 'gravity']), ['avi'], 'example 3');
is_deeply(alternatingvowelsconsonants(['pedalgia', 'pedalboard', 'pedantic']), ['peda'], 'example 4');
is_deeply(alternatingvowelsconsonants(['schoolmaster', 'schoolhouse', 'schooling']), ['ho', 'ol'], 'example 5');

sub common_substring($a0) {
  my @a = sort {length($::a) <=> length($::b)} @{$a0};
  my @results;
  foreach my $l (reverse (1 .. length($a[0]) - 1)) {
    foreach my $offset (0 .. length($a[0]) - $l) {
      my $m = 1;
      my $sample = substr($a[0],$offset, $l);
      foreach my $axi (1 .. $#a) {
        if (index($a[$axi], $sample) == -1) {
          $m = 0;
          last;
        }
      }
      if ($m) {
        push @results, $sample;
      }
    }
  }
  \@results;
}

sub is_avc($a) {
  my $valid = 1;
  my $laststate = 1;
  my @cc = split '', $a;
  while (my ($i, $c) = each @cc) {
    my $thisstate;
    if ($c =~ /[aeiou]/) {
      $thisstate = 1;
    } else {
      $thisstate = 0;
    }
    if ($i > 0 && $thisstate == $laststate) {
      $valid = 0;
      last;
    }
    $laststate = $thisstate;
  }
  $valid;
}

sub alternatingvowelsconsonants($a) {
  my @candidates = @{common_substring($a)};
  my @c2 = grep {is_avc($_)} @candidates;
  if (scalar @c2 > 0) {
    my $l = length($c2[0]);
    return [grep {length($_) == $l} @c2];
  } else {
    return [];
  }
}
