#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

say oct '0b' . join '', reverse get_number() =~ /(\d{4})(\d{4})/;

sub get_number {
  my $err = "Give me an integer less than 256\n";

  die $err unless @ARGV;
  die $err if $ARGV[0] =~ /\D/;
  die $err if $ARGV[0] >= 256;

  return sprintf '%08b', $ARGV[0];
}
