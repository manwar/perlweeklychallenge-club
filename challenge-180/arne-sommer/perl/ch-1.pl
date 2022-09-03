#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $s = $ARGV[0];
my %freq;

map { $freq{$_}++ } split(//, $s);

for my $index (0 .. length($s) -1)
{
  my $char  = 
  my $count = $freq{substr($s, $index,1)};

  if ($count == 1)
  {
    say $index;
    last;
  }
}
