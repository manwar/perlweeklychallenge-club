#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use List::Util 'all';

my @leaders = map  { $ARGV[$_] }
	      grep { is_leader($_, @ARGV) } 0 .. $#ARGV;

say '(', join(', ', @leaders), ')';

sub is_leader {
  my ($needle, @haystack) = @_;

  return 1 if $needle == $#haystack;

  return all { $haystack[$needle] > $_ } @haystack[$needle + 1 .. $#haystack];
}
