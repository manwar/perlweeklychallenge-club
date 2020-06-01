#!/usr/bin/perl

# Perl Weekly Challenge - 063
#
# Task 2 - Rotate String
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Prototype
sub rotateWord ($$);

while (<>) {
  my ($word, $n) = $_ =~ /(\S+)\s+(\d+)/;

  printf "rotateWord('%s', %d) => '%s'\n", 
         $word, $n, rotateWord($word, $n);
}
  
sub rotateWord ($$) {
  my ($word, $rotateNtimes) = @_;

  my @chars = split(//, $word);

  push(@chars, splice(@chars, 0, $rotateNtimes % scalar(@chars)));

  return join('', @chars);
}
