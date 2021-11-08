#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

say oct '0b' . join '', map { scalar reverse } get_number() =~ /(\d\d)/g;

sub get_number {
  my $err = "Give me an integer less than 256\n";

  die $err unless @ARGV;
  die $err if $ARGV[0] =~ /\D/;
  die $err if $ARGV[0] >= 256;

  return sprintf '%08b', $ARGV[0];
}
