#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(wordcount(['unicode', 'xml', 'raku', 'perl']), 2, 'example 1');
is(wordcount(['the', 'weekly', 'challenge']), 2, 'example 2');
is(wordcount(['perl', 'python', 'postgres']), 0, 'example 3');

sub wordcount($a) {
  my $ct = 0;
  foreach my $w (@{$a}) {
    if ($w =~ /^[aeiou]/ || $w =~ /[aeiou]$/) {
      $ct++;
    }
  }
  $ct;
}
