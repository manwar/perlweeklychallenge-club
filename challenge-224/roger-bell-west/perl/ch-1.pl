#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(specialnotes('abc', 'xyz'), 0, 'example 1');
is(specialnotes('scriptinglanguage', 'perl'), 1, 'example 2');
is(specialnotes('aabbcc', 'abc'), 1, 'example 3');

sub word2map($word) {
  my %w;
  map {$w{$_}++} split '',lc($word);
  return \%w;
}

sub specialnotes($chars, $word) {
  my $cm = word2map($chars);
  my $f = word2map($word);
  my $valid = 1;
  foreach my $c (keys %{$f}) {
    if (!exists $cm->{$c} || $f->{$c} > $cm->{$c}) {
      $valid = 0;
      last;
    }
  }
  return $valid;
}
