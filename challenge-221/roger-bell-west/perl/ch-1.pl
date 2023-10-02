#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(goodstrings(['cat', 'bt', 'hat', 'tree'], 'atach'), 6, 'example 1');
is(goodstrings(['hello', 'world', 'challenge'], 'welldonehopper'), 10, 'example 2');

sub word2map($word) {
  my %w;
  map {$w{$_}++} split '',lc($word);
  return \%w;
}

sub goodstrings($words, $chars) {
  my $out = 0;
  my $cm = word2map($chars);
  foreach my $w (@{$words}) {
    my $f = word2map($w);
    my $valid = 1;
    foreach my $c (keys %{$f}) {
      if (!exists $cm->{$c} || $f->{$c} > $cm->{$c}) {
        $valid = 0;
        last;
      }
    }
    if ($valid) {
      $out += length($w);
    }
  }
  return $out;
}
