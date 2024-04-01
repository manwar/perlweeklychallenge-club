#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(mostfrequentword('Joe hit a ball, the hit ball flew far after it was hit.', 'hit'), 'ball', 'example 1');
is(mostfrequentword('Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.', 'the'), 'Perl', 'example 2');

use List::Util qw(max);

sub mostfrequentword($para, $banned) {
  my %words;
  map {$words{$_}++} grep {length($_) > 0} split /[^A-Za-z]+/,$para;
  delete $words{$banned};
  my $m = max(values %words);
  my @v = sort grep {$words{$_} == $m} keys %words;
  return $v[0];
}
