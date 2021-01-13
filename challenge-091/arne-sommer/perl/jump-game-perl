#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(all);

die "Non-negative integers only" unless all { $ ~= /^\d+$/ } @ARGV;

my $index = 0;

while (1)
{
  if ($index == @ARGV -1) { say 1; last; }

  if (defined $ARGV[$index] && $ARGV[$index])
  {
    $index += $ARGV[$index];
  }
  else
  {  
    say 0; last;
  }
}
