#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my ($curr, $last) = (1, 0);
my $iter = 1;

do {
  # say $iter;
  $last = $curr;
  $curr += (1 / ( fact($iter++)));
} until ($last == $curr);

say $curr;

sub fact {
  my ($x) = @_;

  my $fact = 1;
  while ($x) {
    $fact *= $x--;
  }

  return $fact;
}
