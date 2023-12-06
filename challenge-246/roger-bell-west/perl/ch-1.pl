#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

sixoffortynine();

use List::Util qw(shuffle);

sub sixoffortynine {
  my @candidates = (1..49);
  @candidates = shuffle @candidates;
  splice @candidates, 6;
  @candidates = sort {$a <=> $b} @candidates;
  print join(', ', @candidates), "\n";
}
